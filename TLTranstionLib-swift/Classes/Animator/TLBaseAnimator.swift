//
//  TLBaseAnimator.swift
//  Pods
//
//  Created by Andrew on 16/5/9.
//
//

import UIKit

public class TLBaseAnimator: NSObject,UIViewControllerAnimatedTransitioning {

    public var animatorDuration:NSTimeInterval = 0.3
    
    var operaiton:UINavigationControllerOperation?
    
   
    override init() {
        self.operaiton = .Push;
        super.init();
    }
    
    
    
    /**
     动画执行的时间
     
     - parameter transitionContext:
     
     - returns:
     */
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
    
        if(animatorDuration == 0){
          animatorDuration = 0.3
        }
        return animatorDuration;
    }
    
    /**
     具体动画执行的代码
     
     - parameter transitionContext: 动画上下文
     */
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        let model:TransitionModel=TransitionModel(context: transitionContext)
       
        if(self.operaiton == .Push){
            pushOperation(model, context: transitionContext)
        }else if(self.operaiton == .Pop){
            popOperation(model, context: transitionContext)
        }else{
            model.containerView.addSubview(model.toView)
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
    
    /**
     push操作
     
     - parameter model:   封装的转场模型
     - parameter context: 上下文
     */
    func pushOperation(model:TransitionModel,context:UIViewControllerContextTransitioning) -> Void {
        var frame = model.toView.frame
        frame.origin.x = model.fromView.frame.origin.x + model.fromView.frame.size.width
        model.toView.frame=frame
        model.containerView.addSubview(model.toView)
        
        UIView.animateWithDuration(self.animatorDuration, animations: {
            
            model.toView.frame = model.finalFrameForToVC
            
            var frame = model.fromView.frame
            frame.origin.x = frame.origin.x - frame.size.width
            model.fromView.frame = frame
            
            }) { (finished) in
                context.completeTransition(!context.transitionWasCancelled())
        }
    }
    
    func popOperation(model:TransitionModel,context:UIViewControllerContextTransitioning) -> Void {
        var frame = model.toView.frame
        frame.origin.x = model.fromView.frame.origin.x  - model.toView.frame.size.width
        
        model.toView.frame=frame
        
        model.containerView.insertSubview(model.toView, belowSubview: model.fromView)
        
        UIView.animateWithDuration(self.animatorDuration, animations: {
            model.toView.frame=model.finalFrameForToVC
            
            var frame = model.fromView.frame
            frame.origin.x = frame.origin.x + frame.size.width
            model.fromView.frame=frame
            
            }) { (finished) in
                context.completeTransition(!context.transitionWasCancelled())
        }
    
}



}





