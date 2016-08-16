//
//  TLCardAnimator.swift
//  Pods
//
//  Created by Andrew on 16/5/31.
//
//

import UIKit

/// 卡片动画
public class TLCardAnimator: TLBaseAnimator {
    
  
    
    func getAnimatorDuration() -> NSTimeInterval {
        
        if(self.animatorDuration < 1){
            self.animatorDuration = 1
        }
        return animatorDuration
    }

    public override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let model = TransitionModel(context: transitionContext)
        
//        if(self.operaiton == .Push){
//            pushOperation(model, context: transitionContext)
//        }else if(self.operaiton == .Pop){
//            popOperation(model, context: transitionContext)
//        }else{
//            super.animateTransition(transitionContext)
//        }
        
        if(self.isPositiveAnimation == true){
            pushOperation(model, context: transitionContext)
        }else{
            popOperation(model, context: transitionContext)
        }
        
    }
    
    /**
     推送到下一个控制器
     - parameter model:   模型
     - parameter context: 转场的上下文
     */
    override func pushOperation(model: TransitionModel, context: UIViewControllerContextTransitioning) {
        
        let frame = model.fromView.frame
        var offScreenFrame = frame
        offScreenFrame.origin.y = offScreenFrame.height
        
        model.toView.frame = offScreenFrame
        
        //插入视图
        model.containerView.insertSubview(model.toView, aboveSubview: model.fromView)
        
        let t1 = self.firstTransform()
        let t2 = self.secondTransformWithView(model.fromView)
        
        UIView.animateKeyframesWithDuration(getAnimatorDuration(), delay: 0, options: .CalculationModeLinear, animations: {
            
            //动画step1
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.4, animations: {
                model.fromView.layer.transform = t1
                model.fromView.alpha = 0.6
            })
            //动画step2
            UIView.addKeyframeWithRelativeStartTime(0.2, relativeDuration: 0.4, animations: {
                model.fromView.layer.transform = t2
            })
            //动画step3
            UIView.addKeyframeWithRelativeStartTime(0.6, relativeDuration: 0.2, animations: {
                model.toView.frame = CGRectOffset(model.toView.frame, 0, -30)
            })
            
            //动画step4
            UIView.addKeyframeWithRelativeStartTime(0.6, relativeDuration: 0.3, animations: {
                model.toView.frame = frame
            })
            
            
            }) { (finished) in
                model.fromView.frame = frame
                context.completeTransition(!context.transitionWasCancelled())
        }
        
    }
    
    /**
     回滚
     
     - parameter model:   模型
     - parameter context: 转场的上下文
     */
    override func popOperation(model: TransitionModel, context: UIViewControllerContextTransitioning) {
       
        let frame = model.fromView.frame
        model.toView.frame = frame
        
        let scale = CATransform3DIdentity
        model.toView.layer.transform = CATransform3DScale(scale, 0.6, 0.6, 1)
        model.toView.alpha = 0.6
        model.containerView.insertSubview(model.toView, belowSubview: model.fromView)
        
        
        var frameOffsetScreen = frame
        frameOffsetScreen.origin.y = frame.size.height
        
        let t1 = self.firstTransform()
        
        
        UIView.animateKeyframesWithDuration(getAnimatorDuration(), delay: 0, options: .CalculationModeLinear, animations: {
            
            //动画step1
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.3, animations: {
                model.fromView.frame = frameOffsetScreen
            })
            //动画step2
            UIView.addKeyframeWithRelativeStartTime(0.35, relativeDuration: 0.35, animations: {
                model.toView.layer.transform = t1
                model.toView.alpha = 1
            })
            //动画step3
            UIView.addKeyframeWithRelativeStartTime(0.75, relativeDuration: 0.25, animations: {
                model.toView.layer.transform = CATransform3DIdentity
            })
            
        }) { (finished) in
            if context.transitionWasCancelled(){
                model.toView.layer.transform = CATransform3DIdentity
                model.toView.alpha = 1
            }
            context.completeTransition(!context.transitionWasCancelled())
        }
        
    }
    
    //MARK: - Helper Methods
    func firstTransform() -> CATransform3D {
        var t1 = CATransform3DIdentity
        //设置透明度
        t1.m34 = 1/900
        t1 = CATransform3DScale(t1, 0.95, 0.95, 1)
        //在x轴上旋转15度
        t1 = CATransform3DRotate(t1, 15 * CGFloat(M_PI)/180.0, 1, 0, 0)
        return t1
        
    }
    
    func secondTransformWithView(view:UIView) -> CATransform3D {
        var t2 = CATransform3DIdentity
        t2.m34 = self.firstTransform().m34;
        
        //在y轴和Z轴上移动
        t2 = CATransform3DTranslate(t2, 0, view.frame.size.height * -0.08, view.frame.size.height * -0.08);

        t2  = CATransform3DScale(t2, 0.8, 0.8, 1)
        
        return t2
    }
    
    
    
}
