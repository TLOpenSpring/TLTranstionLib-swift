//
//  TLPinchInteraction.swift
//  Pods
//
//  Created by Andrew on 16/8/8.
//
//

import UIKit

let PinchInteractionDefaultCompletionPercentage:CGFloat = 0.5;


/// 手指捏合的交互手势
public class TLPinchInteraction: UIPercentDrivenInteractiveTransition,TLTransitionInteractionProtocol,UIGestureRecognizerDelegate {

    var fromViewController:UIViewController?
    
    var gestureRecognizer:UIPinchGestureRecognizer{
        let gesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        gesture.delegate = self
        return gesture
    }
    
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
    
    func attachGestureRecognizerToView(view:UIView) -> Void {
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    deinit{
        self.gestureRecognizer.view?.removeGestureRecognizer(self.gestureRecognizer)
    }
    
    
    /**
     滑动手势的百分比
     
     - parameter pinchGestureRecognizer: 手势
     
     - returns:
     */
    func translationPercentageWithPinchGestureRecognizer(pinchGestureRecognizer:UIPinchGestureRecognizer) -> CGFloat {
        return pinchGestureRecognizer.scale / 2
    }
    
    func isPinchWithGesture(pinchGestureRecognizer:UIPinchGestureRecognizer) -> Bool {
        return pinchGestureRecognizer.scale < 1
    }
    
    
    
    
    
    
    
    
    
    
    //MARK: - 手势处理
    func handlePanGesture(pinchGesture:UIPinchGestureRecognizer) -> Void {
         let percentage = self.translationPercentageWithPinchGestureRecognizer(pinchGesture)
        
       

        let isPinch = self.isPinchWithGesture(pinchGesture)
        switch pinchGesture.state {
        case .Began:
            self.isInteractive = true
            
            if  let nextDelegate = self.nextControllerDelegate{
            
                if !isPinch && nextDelegate is TLTransitionInteractionControllerDelegate{
                   
                    if (action == TLTranstionAction.tl_Push){
                        self.fromViewController?.navigationController?.pushViewController(self.nextControllerDelegate!.nextViewControllerForInteractor(self), animated: true)
                    }else if(action == TLTranstionAction.tl_Present){
                       self.fromViewController?.presentViewController(self.nextControllerDelegate!.nextViewControllerForInteractor(self), animated: true, completion: nil)
                    }
                }else{
                    if action == TLTranstionAction.tl_Pop{
                        //取消交互
                      self.cancelInteractiveTransition()
                        self.isInteractive = false
                        self.fromViewController?.navigationController?.popViewControllerAnimated(true)
                    }else if(action == TLTranstionAction.tl_Dismiss){
                        //取消交互
                        self.cancelInteractiveTransition()
                        self.isInteractive = false
                        self.fromViewController?.dismissViewControllerAnimated(true, completion: nil)
                    }
                }
                
            }
            
            
           
            break
        case .Changed:
            if self.isInteractive == true{
                self.shouldCompleteTransition = percentage > PinchInteractionDefaultCompletionPercentage
                
                self.updateInteractiveTransition(percentage)
            }
            break
        case .Cancelled:
            self.isInteractive = false
            self.cancelInteractiveTransition()
            break
        case .Ended:
            if self.isInteractive{
             self.isInteractive = false
                if !self.shouldCompleteTransition || pinchGesture.state == .Cancelled{
                 self.cancelInteractiveTransition()
                }else{
                 self.finishInteractiveTransition()
                }
            }
            break
        default:
            break
        }
    }
    
    
    
    
}
