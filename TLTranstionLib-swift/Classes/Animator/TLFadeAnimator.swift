//
//  TLFadeAnimator.swift
//  Pods
//
//  Created by Andrew on 16/5/14.
//
//

import UIKit

public class TLFadeAnimator: TLBaseAnimator {

    /**
     具体执行动画的代码
     
     - parameter transitionContext: 动画执行的上下文
     */
    public override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let model:TransitionModel=TransitionModel(context: transitionContext)
        
        if(self.isPositiveAnimation == true){
            model.containerView.addSubview(model.toView)
            model.toView.alpha=0
            UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: {
                model.toView.alpha=1
                }, completion: { (finished) in
                    
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled());
            });
        }else {
            model.containerView.insertSubview(model.toView, belowSubview: model.fromView)
            
            UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: {
                    model.fromView.alpha=0
                }, completion: { (finished) in
                    
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            })
        }
        
    }
}
