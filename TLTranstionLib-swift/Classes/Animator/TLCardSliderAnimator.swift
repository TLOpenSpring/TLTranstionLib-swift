//
//  TLCardSliderAnimator.swift
//  Pods
//
//  Created by Andrew on 16/8/16.
//
//

import UIKit

let TLSlideTransitionTime:CGFloat =  0.35
let TLSlideScaleChangePct:CGFloat = 0.33

public class TLCardSliderAnimator: NSObject,TLAnimationProtocol {

    /// 是否
    var horizontalOrientation:Bool = true
    /// 默认是正向
    public var isPositiveAnimation: Bool = true
    
    public var transitionTime:NSTimeInterval = 0.4
    /// 默认的背景颜色
    var containerBackgroundColor:UIColor = UIColor.blackColor()
    
    
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return transitionTime
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let model = TransitionModel(context: transitionContext)
        
        
        
        if self.isPositiveAnimation == true{
          pushOperation(model, context: transitionContext)
        }else{
          popOperation(model, context: transitionContext)
        }
    }
    
    
    func pushOperation(model: TransitionModel, context: UIViewControllerContextTransitioning){
        let bgView = UIView(frame: model.containerView.bounds)
        bgView.autoresizingMask = [.FlexibleWidth,.FlexibleHeight]
        bgView.backgroundColor = self.containerBackgroundColor
        model.containerView.insertSubview(bgView, atIndex: 0)
        var containerView = model.containerView
        
        model.containerView.insertSubview(model.toView, belowSubview: model.fromView)
        model.toView.frame = containerView.frame
        model.toView.transform = CGAffineTransformMakeScale(1-TLSlideScaleChangePct, 1-TLSlideScaleChangePct)
        model.toView.alpha = 0.1
        
        
        UIView.animateWithDuration(self.transitionTime,
                                   delay: 0,
                                   options: .CurveEaseOut,
                                   animations: {
                                    
                                    model.toView.transform = CGAffineTransformIdentity
                                    model.toView.alpha = 1
                                    if self.horizontalOrientation == true{
                                       model.fromView.transform = CGAffineTransformMakeTranslation(-containerView.bounds.size.width, 0)
                                    }else{
                                       model.fromView.transform = CGAffineTransformMakeTranslation(0, containerView.bounds.size.height)
                                    }
                                    
                                    
            }) { (finished) in
                model.toView.transform = CGAffineTransformIdentity
                model.fromView.transform = CGAffineTransformIdentity
                bgView.removeFromSuperview()
                
                context.completeTransition(!context.transitionWasCancelled())
        }
        
        
    }
    
    func popOperation(model: TransitionModel, context: UIViewControllerContextTransitioning){
        let bgView = UIView(frame: model.containerView.bounds)
        bgView.autoresizingMask = [.FlexibleWidth,.FlexibleHeight]
        bgView.backgroundColor = self.containerBackgroundColor
        model.containerView.insertSubview(bgView, atIndex: 0)
        var containerView = model.containerView
        
        
        containerView.addSubview(model.toView)
        if self.horizontalOrientation == true{
           model.toView.transform = CGAffineTransformMakeTranslation(-containerView.bounds.size.width, 0)
        }else{
            model.toView.transform = CGAffineTransformMakeTranslation(0, containerView.bounds.size.height)

        }
        
        UIView.animateWithDuration(self.transitionTime,
                                   delay: 0,
                                   options: .CurveEaseOut,
                                   animations: {
                                    
                                    model.toView.transform = CGAffineTransformIdentity
                                    model.fromView.transform = CGAffineTransformMakeScale(1-TLSlideScaleChangePct, 1-TLSlideScaleChangePct)
                                    model.fromView.alpha = 0.1
                                    
                                    
            }) { (finished) in
                
                model.toView.transform = CGAffineTransformIdentity
                model.fromView.transform = CGAffineTransformIdentity
                model.fromView.alpha = 1
                
                bgView.removeFromSuperview()
                context.completeTransition(!context.transitionWasCancelled())
                
        }
        
    }
    
}
