//
//  TLTransitionManager.swift
//  Pods
//  管理类
//  Created by Andrew on 16/8/5.
//
//

import UIKit

enum TLTranstionAction:Int {
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

class TLTransitionManager: NSObject,UINavigationControllerDelegate,UITabBarControllerDelegate,UIViewControllerTransitioningDelegate{

    /// 在一个UINavigationCtroller进行推送或者Pop操作中时的默认动画
    var defaultPushPopAnimation:TLAnimationProtocol?
    
    /// 在一个UIViewControleller中进行present或者dismiss时候的默认动画
    var defaultPresentDismissAnimation:TLAnimationProtocol?

    /// 在使用TabBar的时候默认动画
    var defaultTabBarAnimation:TLAnimationProtocol?
    
    var animationControllers = [TLUniqueTransitionModel:TLAnimationProtocol]()
    var animationControllerDirectionOverrides = [String:AnyObject]()
    var interactionControllers = [String:AnyObject]()
    
    
    //单例
    class func shared()->TLTransitionManager{
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
    func tl_setAnimation(animation animation:TLAnimationProtocol,fromViewController:AnyClass,action:TLTranstionAction) -> Void {
        
        
    }
    /**
     设置动画的效果，当一个UIViewController到另一个UIViewController时,
     
     - parameter animation:          动画实现类
     - parameter fromViewController: 开始过渡的动画类
     - parameter toViewController:   The @c UIViewController class that is being transitioned to.
     - parameter action:             操作类型，比如推送(push),pop(弹回),present(跳转),dismiss(消失)
     */
    func tl_setAnimation(animation animation:TLAnimationProtocol,fromViewController:AnyClass,toViewController:AnyClass,action:TLTranstionAction) -> Void {
        //获取转换Action的集合
        let arrayActions = self.getTranstionByAction(action)
        
        var uniqueKey:TLUniqueTransitionModel!
        for item in arrayActions {
            uniqueKey = TLUniqueTransitionModel(action: item, fromController: fromViewController, toController: toViewController)
            self.animationControllers[uniqueKey!] = animation
        }
        
    }
    
    /**
     当一个UIViewController到另一个UIViewController时，设置交互效果
     
     - parameter interactionController: 当过渡的时候的交互控制器
     - parameter fromController:        过渡动画的开始的地方
     - parameter toController:          过渡动画的目标地址
     - parameter action:                 交互动作,EX:pop,push,present,dismiss
     */
    func tl_setInteraction(interactionController interactionController:TLTransitionInteractionProtocol,fromController:AnyClass,toController:AnyClass,action:TLTranstionAction) -> Void {
        
    }
    
    //MARK: - UIViewControllerTransitioningDelegate
    
    /**
     Asks your delegate for the transition animator object to use when presenting a view controller.
     The animator object to use when presenting the view controller or nil if you do not want to present the view controller using a custom transition. The object you return should be capable of performing a fixed-length animation that is not interactive
     
     - parameter presented:  <#presented description#>
     - parameter presenting: <#presenting description#>
     - parameter source:     <#source description#>
     
     - returns: <#return value description#>
     */
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let keyValue = TLUniqueTransitionModel(action: .tl_Present, fromController: source.classForCoder, toController: presented.classForCoder)
        //得到动画协议的实现类
        var animation = self.animationControllers[keyValue]
        
        if animation == nil{
            keyValue.toViewController = nil
            animation = self.animationControllers[keyValue]
        }
        if animation == nil{
           animation = self.defaultPresentDismissAnimation
        }
        return animation
    }
    
    /**
     Asks your delegate for the transition animator object to use when dismissing a view controller.
     The animator object to use when dismissing the view controller or nil if you do not want to dismiss the view controller using a custom transition. The object you return should be capable of performing a fixed-length animation that is not interactive.
     
     - parameter dismissed: The view controller object that is about to be dismissed.
     
     - returns: The animator object to use when dismissing the view controller or nil if you do not want to dismiss the view controller using a custom transition.
     */
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let keyValue = TLUniqueTransitionModel(action: .tl_Dismiss, fromController: dismissed.classForCoder, toController: nil)
        
        var animation:TLAnimationProtocol?
        
        let presentingViewController = dismissed.presentingViewController
        
        if presentingViewController is UINavigationController{
         
            let childVc = presentingViewController?.childViewControllers.last
            if childVc != nil{
                keyValue.toViewController = childVc?.classForCoder
                animation = self.animationControllers[keyValue]
            }
            
            if animation == nil{
             keyValue.toViewController = nil
                animation = self.animationControllers[keyValue]
            }
            if animation == nil{
             keyValue.toViewController = childVc?.classForCoder
                keyValue.fromViewController = nil
                animation = self.animationControllers[keyValue]
                
            }
        }
        
        if animation == nil{
         keyValue.toViewController = nil
            keyValue.fromViewController = dismissed.classForCoder
            animation = self.animationControllers[keyValue]
            
        }
        
        if animation == nil{
          animation = self.defaultPresentDismissAnimation
        }
        
        return animation!
        
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
