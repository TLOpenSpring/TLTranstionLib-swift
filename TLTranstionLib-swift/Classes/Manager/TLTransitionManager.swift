//
//  TLTransitionManager.swift
//  Pods
//  管理类
//  Created by Andrew on 16/8/5.
//
//

import UIKit

public enum TLTranstionAction:Int {
    case tl_Push
    case tl_Pop
    case tl_Present
    case tl_Dismiss
    case tl_Tab
    /// tl_Push && tl_Pop
    case tl_PushPop
    /// tl_Present && tl_Dismiss
    case tl_PresentDismiss
    //tl_Push && tl_Pop && tl_Present && tl_Dismiss && tl_Tab
    case tl_Any
    
   
}


private let TransitionsAnyViewControllerKey = "kRZTTransitionsAnyViewControllerKey";
private let TransitionsKeySpacer = "_";

public class TLTransitionManager: NSObject,UINavigationControllerDelegate,UITabBarControllerDelegate,UIViewControllerTransitioningDelegate{

    /// 在一个UINavigationCtroller进行推送或者Pop操作中时的默认动画
    public var defaultPushPopAnimation:TLAnimationProtocol?
    
    /// 在一个UIViewControleller中进行present或者dismiss时候的默认动画
    public var defaultPresentDismissAnimation:TLAnimationProtocol?

    /// 在使用TabBar的时候默认动画
    public var defaultTabBarAnimation:TLAnimationProtocol?
    
    var animationControllers = [TLUniqueTransitionModel:TLAnimationProtocol]()
    var animationControllerDirectionOverrides = [TLUniqueTransitionModel:Bool]()
    
    var interactionControllers = [TLUniqueTransitionModel:TLTransitionInteractionProtocol]()
    
    
    //单例
   public class func shared()->TLTransitionManager{
        struct Singleton{
            static var onceToken : dispatch_once_t = 0
            static var single:TLTransitionManager?
        }
        dispatch_once(&Singleton.onceToken,{
            Singleton.single=TLTransitionManager()
            }
        )
        return Singleton.single!
    }

    //MARK: -  公共的API去设置动画效果和手势交互
    /**
     设置动画的效果，当一个UIViewController到另一个UIViewController时
     
     - parameter animation:          动画实现类
     - parameter fromViewController: 开始过渡的动画类
     - parameter action:             操作类型，比如推送(push),pop(弹回),present(跳转),dismiss(消失)
     */
   public func tl_setAnimation(animation animation:TLAnimationProtocol,fromViewController:AnyClass,action:TLTranstionAction) -> Void {
        
        return tl_setAnimation(animation: animation, fromViewController: fromViewController, toViewController: nil, action: action)
    }
    /**
     设置动画的效果，当一个UIViewController到另一个UIViewController时,
     
     - parameter animation:          动画实现类
     - parameter fromViewController: 开始过渡的动画类
     - parameter toViewController:   The @c UIViewController class that is being transitioned to.
     - parameter action:             操作类型，比如推送(push),pop(弹回),present(跳转),dismiss(消失)
     */
    public func tl_setAnimation(animation animation:TLAnimationProtocol,fromViewController:AnyClass?,toViewController:AnyClass?,action:TLTranstionAction) -> Void {
        //获取转换Action的集合
        let arrayActions = self.getTranstionByAction(action)
        
        
   

        
        var uniqueKey:TLUniqueTransitionModel!
        for item in arrayActions {
            
            var tempFromController:AnyClass? = fromViewController
            var tempToController:AnyClass? = toViewController
            
            if (item == TLTranstionAction.tl_Pop ){
                tempFromController = toViewController
                tempToController = fromViewController
            }
            else if item == TLTranstionAction.tl_Dismiss{
                tempFromController = toViewController
                tempToController = nil
            }
            
            
            uniqueKey = TLUniqueTransitionModel(action: item, fromController: tempFromController, toController: tempToController)
            
            var animationModel = self.animationControllers.equalsUniqueModel(uniqueKey)
            
            if animationModel != nil{
                self.animationControllers.removeUniqueKey(uniqueKey)
                self.animationControllers[uniqueKey!] = animation
                
            }else{
                self.animationControllers[uniqueKey!] = animation
            }
            
            
        }
        
    }
    
    /**
     当一个UIViewController到另一个UIViewController时，设置交互效果
     
     - parameter interactionController: 当过渡的时候的交互控制器
     - parameter fromController:        过渡动画的开始的地方
     - parameter toController:          过渡动画的目标地址
     - parameter action:                 交互动作,EX:pop,push,present,dismiss
     */
    public func tl_setInteraction(interactionController interactionController:TLTransitionInteractionProtocol,fromController:AnyClass,toController:AnyClass?,action:TLTranstionAction) -> Void {
        //获取转换Action的集合
        let arrayActions = self.getTranstionByAction(action)
        var uniqueKey:TLUniqueTransitionModel!
        for item in arrayActions {
            
            var tempFromController:AnyClass? = fromController
            var tempToController:AnyClass? = toController
            
            if (item == TLTranstionAction.tl_Pop || item == TLTranstionAction.tl_Dismiss){
                tempToController = nil
            }
            
            uniqueKey = TLUniqueTransitionModel(action: item, fromController: tempFromController, toController: tempToController)
            
            var interaction = self.interactionControllers.equalsUniqueModel(uniqueKey)
            if interaction != nil{
                self.interactionControllers.removeUniqueKey(uniqueKey)
                self.interactionControllers[uniqueKey] = interactionController
            }else{
                self.interactionControllers[uniqueKey] = interactionController
            }
        }
        
    }
    
    /**
     覆盖指定的的过渡方向（推送或者回滚(dismiss)）
     
     - parameter override:   是否覆盖
     - parameter transition: 过渡的模型类的唯一key
     */
    func overrideAnimationDirection(override:Bool,uniqueTransitionModel:TLUniqueTransitionModel) -> Void {
        self.animationControllerDirectionOverrides[uniqueTransitionModel] = override
    }
    
    //MARK: - UIViewControllerTransitioningDelegate
    
    /**
     Asks your delegate for the transition animator object to use when presenting a view controller.
     The animator object to use when presenting the view controller or nil if you do not want to present the view controller using a custom transition. The object you return should be capable of performing a fixed-length animation that is not interactive
     
     - parameter presented:  presented description
     - parameter presenting: presenting description
     - parameter source:     source description
     
     - returns: <#return value description#>
     */
    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let keyValue = TLUniqueTransitionModel(action: .tl_Present, fromController: source.classForCoder, toController: presented.classForCoder)
        //得到动画协议的实现类
        var animation = self.animationControllers.equalsUniqueModel(keyValue) as? TLAnimationProtocol
        
        if animation == nil{
            keyValue.toViewController = nil
            animation = self.animationControllers.equalsUniqueModel(keyValue) as? TLAnimationProtocol
        }
        if animation == nil{
           animation = self.defaultPresentDismissAnimation
        }
        
        animation?.isPositiveAnimation = true
        animation?.showType = .present
        return animation
    }
    
    /**
     Asks your delegate for the transition animator object to use when dismissing a view controller.
     The animator object to use when dismissing the view controller or nil if you do not want to dismiss the view controller using a custom transition. The object you return should be capable of performing a fixed-length animation that is not interactive.
     
     - parameter dismissed: The view controller object that is about to be dismissed.
     
     - returns: The animator object to use when dismissing the view controller or nil if you do not want to dismiss the view controller using a custom transition.
     */
    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let keyValue = TLUniqueTransitionModel(action: .tl_Dismiss, fromController: dismissed.classForCoder, toController: nil)
        
        var animation:TLAnimationProtocol?
        
        let presentingViewController = dismissed.presentingViewController
        
        if presentingViewController is UINavigationController{
         
            let childVc = presentingViewController?.childViewControllers.last
            if childVc != nil{
                keyValue.toViewController = childVc?.classForCoder
                animation = self.animationControllers.equalsUniqueModel(keyValue) as? TLAnimationProtocol
            }
            
            if animation == nil{
                keyValue.toViewController = nil
                animation = self.animationControllers.equalsUniqueModel(keyValue) as? TLAnimationProtocol
            }
            if animation == nil{
                keyValue.toViewController = childVc?.classForCoder
                keyValue.fromViewController = nil
                animation = self.animationControllers.equalsUniqueModel(keyValue) as? TLAnimationProtocol
                
            }
            animation?.isPositiveAnimation = false
            animation?.showType = TLShowType.dismiss
            return animation
        }
        
         animation = self.animationControllers.equalsUniqueModel(keyValue) as? TLAnimationProtocol
        
        if animation == nil{
            keyValue.toViewController = nil
            animation = self.animationControllers.equalsUniqueModel(keyValue) as? TLAnimationProtocol
        }
        
        if animation == nil{
            keyValue.toViewController = nil
            keyValue.fromViewController = dismissed.classForCoder
            animation = self.animationControllers.equalsUniqueModel(keyValue) as? TLAnimationProtocol
            
        }
        
        if animation == nil{
          animation = self.defaultPresentDismissAnimation
        }
        animation?.isPositiveAnimation = false
        animation?.showType = TLShowType.dismiss
        return animation
        
    }
    /**
     Asks your delegate for the interactive animator object to use when presenting a view controller.
     
     - parameter animator:
     
     - returns:
     */
   public func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        var returnInteraction:UIViewControllerInteractiveTransitioning?
        
        for(key,value) in self.animationControllers{
            //三个等号比较的是内存地址
            if animator === value  && key.transitionAction == TLTranstionAction.tl_Present{
             
                //获取交互手势
                var interactionController = self.interactionControllers.equalsUniqueModel(key) as? TLTransitionInteractionProtocol
                if interactionController == nil{
                    key.toViewController = nil
                    interactionController = self.interactionControllers.equalsUniqueModel(key) as? TLTransitionInteractionProtocol
                }
                
                if let interaction = interactionController where interaction.isInteractive == true{
                   returnInteraction = interaction
                    break
                }
            }
        }
        return returnInteraction
    }
    
    /**
     Asks your delegate for the interactive animator object to use when dismissing a view controller.
     
     - parameter animator:
     
     - returns:
     */
   public func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        var returnInteraction:UIViewControllerInteractiveTransitioning?
        
        for(key,value) in self.animationControllers{
            //三个等号比较的是内存地址
            if animator === value  && key.transitionAction == TLTranstionAction.tl_Dismiss{
                
                //获取交互手势
                var interactionController = self.interactionControllers.equalsUniqueModel(key) as? TLTransitionInteractionProtocol
                if interactionController == nil{
                    key.toViewController = nil
                    interactionController = self.interactionControllers.equalsUniqueModel(key) as? TLTransitionInteractionProtocol
                }
                
                if let interaction = interactionController where interaction.isInteractive == true{
                    returnInteraction = interaction
                    break
                }
            }
        }
        return returnInteraction
    }
    
    
    
    
    
    
    
    
    //MARK: - UINaviagationController delegate
    /**
     Called to allow the delegate to return an interactive animator object for use during view controller transitions.
     
     - parameter navigationController: 导航控制器
     - parameter animationController:  动画效果
     
     - returns:
     */
    public func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return interactionControllerForAction(TLTranstionAction.tl_PushPop, animator: animationController)
    }
    public func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        
        let action = operation == .Push ? TLTranstionAction.tl_Push : TLTranstionAction.tl_Pop
        
        let keyValue = TLUniqueTransitionModel(action: action, fromController: fromVC.classForCoder, toController: toVC.classForCoder)
        
        var aniation = self.animationControllers.equalsUniqueModel(keyValue) as? TLAnimationProtocol
        
        
        if aniation == nil{
            keyValue.toViewController = nil
            aniation = self.animationControllers.equalsUniqueModel(keyValue) as? TLAnimationProtocol
        }
        
        if aniation == nil{
            keyValue.toViewController = toVC.classForCoder
            keyValue.fromViewController = nil
            aniation = self.animationControllers.equalsUniqueModel(keyValue) as? TLAnimationProtocol
        }
        
        //add by Andrew
        //如果目标控制器和源头控制器都为nil,则对任何页面都起作用
//        if aniation == nil{
//            keyValue.fromViewController = nil
//            keyValue.toViewController = nil
//            aniation = self.animationControllers.equalsUniqueModel(keyValue)
//        }
        
        //如果上面的控制仍然获取的animation为nil,则调用默认的动画实现
        if aniation == nil{
            aniation = self.defaultPushPopAnimation
        }
        
        if operation == .Push{
            aniation?.isPositiveAnimation = true
            aniation?.showType = .push
        }else if(operation == .Pop){
            aniation?.isPositiveAnimation = false
            aniation?.showType = .pop
        }
        return aniation
    }
   
    
    //MARK: - UIInteractionController Caching
    func interactionControllerForAction(action:TLTranstionAction,animator:UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        for (key,value) in self.interactionControllers {
            if value.action == action &&  value.isInteractive == true{
              return value
            }
        }
        return nil
    }
    
    
    //MARK: - UITabbarViewController delegate
    public func tabBarController(tabBarController: UITabBarController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactionControllerForAction(TLTranstionAction.tl_Tab, animator: animationController)
    }
    
    public func tabBarController(tabBarController: UITabBarController, animationControllerForTransitionFromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        var fromVcs = fromVC.classForCoder
        var fromController:UIViewController?
        if fromVcs is UINavigationController{
          fromController = (fromVcs as! UINavigationController).viewControllers[0]
        }else{
          fromController = fromVC
        }
        
        let keyValue = TLUniqueTransitionModel(action: TLTranstionAction.tl_Tab, fromController: fromController!.classForCoder, toController: toVC.classForCoder)
        
        var animation = self.animationControllers.equalsUniqueModel(keyValue) as? TLAnimationProtocol
        if animation == nil{
            keyValue.toViewController = nil
            animation = self.animationControllers.equalsUniqueModel(keyValue) as? TLAnimationProtocol
        }
        
        if animation == nil{
            animation = self.defaultTabBarAnimation
        }
        
        let fromVcIndex = tabBarController.viewControllers?.indexOf(fromVC)
        let toVcIndex = tabBarController.viewControllers?.indexOf(toVC)
        
        if (animation != nil && self.animationControllerDirectionOverrides[keyValue] == false){
            animation?.isPositiveAnimation = fromVcIndex>toVcIndex
        }
        
        return animation
        
    }
}


extension TLTransitionManager{
    /**
     根据Action的类型转换为具体的几种类型集合
     
     - parameter action:
     
     - returns:
     */
    func getTranstionByAction(action:TLTranstionAction) -> [TLTranstionAction] {
        
        var arrayAction:[TLTranstionAction]!
        switch action {
        case .tl_PushPop:
            arrayAction = [.tl_Push,.tl_Pop]
        case .tl_PresentDismiss:
            arrayAction = [.tl_Present,.tl_Dismiss]
        case .tl_Any:
            arrayAction = [.tl_Present,.tl_Dismiss,.tl_Push,.tl_Pop,.tl_Tab]
        default:
            arrayAction = [action]
        }
        
        return arrayAction
    }
}



extension Dictionary{
    func equalsUniqueModel(obj:TLUniqueTransitionModel) -> AnyObject? {
        for (key,value) in self {
            if let model = key as? TLUniqueTransitionModel{
                if model.isEqual(obj) == true{
                  return value as? AnyObject
                }
            }
        }
        return nil
    }
    
    
    mutating func removeUniqueKey(obj:TLUniqueTransitionModel) -> Void {
            for (key,value) in self {
                if let model = key as? TLUniqueTransitionModel{
                    if model.isEqual(obj) == true{
                        self.removeValueForKey(key)
                    }
                }
            }
    }
}
