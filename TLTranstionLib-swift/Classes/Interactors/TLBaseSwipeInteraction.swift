//
//  TLBaseSwipeInteraction.swift
//  Pods
//
//  Created by Andrew on 16/8/8.
//
//

import UIKit

/*
  UIPercentDrivenInteractiveTransition。这个类的对象会根据我们的手势，来决定我们的自定义过渡的完成度。我们把这些都放到手势识别器的 action 方法中去
 当手势刚刚开始，我们创建一个 UIPercentDrivenInteractiveTransition 对象，然后让 navigationController 去把当前这个 viewController 弹出。
 
 当手慢慢划入时，我们把总体手势划入的进度告诉 UIPercentDrivenInteractiveTransition 对象。
 
 当手势结束，我们根据用户的手势进度来判断过渡是应该完成还是取消并相应的调用 finishInteractiveTransition 或者 cancelInteractiveTransition 方法.
 */

private let TLBaseSwipeInteractionDefaultCompletionPercentage:CGFloat = 0.3
public class TLBaseSwipeInteraction: UIPercentDrivenInteractiveTransition,TLTransitionInteractionProtocol,UIGestureRecognizerDelegate {

    
    var fromViewController:UIViewController?
    /// 滑动的手势
    var gestureRecognizer:UIPanGestureRecognizer{
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        gesture.delegate = self
        return gesture
    }
    /// 当手势滑动的方向相反时是否触发手势
    public var reverseGestureDirection:Bool = false
    
    //MARK: - TLTransitionInteractionProtocol属性
    public var isInteractive: Bool = true
    public var shouldCompleteTransition: Bool = false
    public var action: TLTranstionAction = TLTranstionAction.tl_Any
    public var nextControllerDelegate: TLTransitionInteractionControllerDelegate?
    
    
    public func attachViewController(viewController viewController: UIViewController, action: TLTranstionAction) {
        self.fromViewController = viewController
        self.action = action
        //给当前控制器添加手势
        self.attachGestureRecognizerToView((self.fromViewController?.view)!)
    }
    
    deinit{
      self.gestureRecognizer.view?.removeGestureRecognizer(self.gestureRecognizer)
    }
    
    /**
     添加手势
     - parameter view:
     */
    func attachGestureRecognizerToView(view:UIView) -> Void {
        view.addGestureRecognizer(self.gestureRecognizer)
    }
    

    
    //MARK: - UIPercentDrivenInteractiveTransition
    
    
    /**
     Flag if the gesture is in the positive or negative direction
     
     - parameter panGestureRecognizer: 滑动手势
     
     - returns: Flag if the gesture is in the positive or negative direction
     */
    func isGesturePositive(panGestureRecognizer:UIPanGestureRecognizer) -> Bool {
        
        fatalError("子类必须实现这个方法\(isGesturePositive)")
        
        return true
    }
    
    
    /**
     当手势滑动的时候该方法会被触发
     滑动手势的百分比
     
     - parameter precent: 滑动的百分比
     
     - returns: 距离完成手势操作的百分比
     */
    func swipeCompletionPercent() -> CGFloat {
        return TLBaseSwipeInteractionDefaultCompletionPercentage
    }
    
    /**
     The translation percentage of the passed gesture recognizer
     
     - parameter panGestureRecognizer:
     
     - returns: 完成手势的百分比
     */
    func translationPercentageWithPanGestureRecongizer(panGestureRecognizer panGestureRecognizer:UIPanGestureRecognizer) -> CGFloat {
        
        fatalError("子类必须覆盖这个方法：\(translationPercentageWithPanGestureRecongizer))")
        return 0
    }
    
    
    
    /**
     
     The physical translation that is on the the view due to the panGestureRecognizer
     - parameter panGestureRecognizer: 滑动手势
     
     - returns: the translation that is currently on the view.
     */
    func translationWithPanGestureRecongizer(panGestureRecognizer panGestureRecognizer:UIPanGestureRecognizer) -> CGFloat {
          fatalError("子类必须覆盖这个方法：\(translationWithPanGestureRecongizer))")
        return 0
    }
    
    
    //MARK: - UIPanGestureRecognizer Delegate
    func handlePanGesture(panGestureRecognizer:UIPanGestureRecognizer) -> Void {
        let percentage = self.translationPercentageWithPanGestureRecongizer(panGestureRecognizer: panGestureRecognizer)
        //判断是否是正向还是逆向
        let positiveDirection = self.reverseGestureDirection ? !self.isGesturePositive(panGestureRecognizer) : self.isGesturePositive(panGestureRecognizer)
        
        switch panGestureRecognizer.state {
        case .Began:
            //允许用户交互
            self.isInteractive = true
            //如果是正向操作，并且下一个控制器实现了TLTransitionInteractionProtocol协议
            
            if let nextDelegate = self.nextControllerDelegate{
                if positiveDirection && nextDelegate is TLTransitionInteractionControllerDelegate{
                    //如果操作类型是 push
                    if action == TLTranstionAction.tl_Push{
                        self.fromViewController?.navigationController?.pushViewController((self.nextControllerDelegate?.nextViewControllerForInteractor(self))!, animated: true)
                    }else if (action == TLTranstionAction.tl_Present){
                        
                        self.fromViewController?.presentViewController((self.nextControllerDelegate?.nextViewControllerForInteractor(self))!, animated: true, completion: nil)
                    }
                }else{
                    //如果是逆向操作
                    if action == TLTranstionAction.tl_Pop{
                        self.fromViewController?.navigationController?.popViewControllerAnimated(true)
                    }else if action == TLTranstionAction.tl_Dismiss{
                        self.fromViewController?.dismissViewControllerAnimated(true, completion: nil)
                    }
                }
            }
          
        case .Changed:
            //如果是允许交互
            if self.isInteractive{
                self.shouldCompleteTransition = (percentage >= TLBaseSwipeInteractionDefaultCompletionPercentage)
                self.updateInteractiveTransition(percentage)
            }
            break
        case .Cancelled:
            break
        case .Ended:
            if isInteractive{
                //如果交互没有完成
                if self.shouldCompleteTransition == false{
                    self.cancelInteractiveTransition()
                }else{
                    self.finishInteractiveTransition()
                }
            }
            self.isInteractive = false
            break
        default:
            break
        }
        
    }
    
  
    
    
    
    
}
