//
//  TLCubeAnimator.swift
//  Pods
//  3D翻转
//  Created by Andrew on 16/5/31.
//
//

import UIKit

private let PERSPECTIVE = CGFloat(-1.0 / 200.0)
private let ROTATION_ANGLE  = CGFloat(M_PI_2)

public class TLCubeAnimator: TLBaseAnimator {

    /**
     翻转方向
     
     - horizontal: 水平方向
     - vertical:   垂直方向
     */
  public enum TLCubeDirecation {
        case horizontal
        case vertical
    }
    /**
     翻转类型
     
     - normal:  普通
     - inverse: 上下翻转
     */
  public  enum TLCubeType {
        case normal
        case inverse
    }
    
    
   public  var cubetype = TLCubeType.normal
   public var cubeDirecation = TLCubeDirecation.horizontal
    
    public override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let model = TransitionModel(context: transitionContext)
        //创建不同的3D效果
        var viewFromTransform:CATransform3D?
        var viewToTransform:CATransform3D?
        
        var dir:CGFloat = 1
        if self.operaiton == .Pop{
            dir = -dir
        }
        
        switch cubeDirecation {
        case .horizontal:
            //旋转90度
            viewFromTransform = CATransform3DMakeRotation(dir*ROTATION_ANGLE, 0, 1, 0)
            viewToTransform = CATransform3DMakeRotation(-dir*ROTATION_ANGLE, 0, 1, 0)
            model.toView.layer.anchorPoint = CGPointMake(dir == 1 ? 0 : 1, 0.5)
            model.fromView.layer.anchorPoint = CGPointMake(dir == 1 ? 1 : 0, 0.5)
            model.containerView.transform = CGAffineTransformMakeTranslation(dir*(model.containerView.frame.size.width/2), 0)
        case .vertical:
            
            viewFromTransform = CATransform3DMakeRotation(-dir*ROTATION_ANGLE, 1, 0, 0)
            viewToTransform = CATransform3DMakeRotation(dir*ROTATION_ANGLE, 1, 0, 0)
            
            model.toView.layer.anchorPoint = CGPointMake(0.5, dir == 1 ? 0 : 1)
            model.fromView.layer.anchorPoint = CGPointMake(0.5, dir == 1 ? 1 : 0)
            model.containerView.transform = CGAffineTransformMakeTranslation(0, dir*(model.containerView.frame.size.height)/2.0)
            break
  
        }
        
        
        //设置透明度,只有在旋转的时候这个属性才有效
        viewFromTransform?.m34 = PERSPECTIVE
        viewToTransform?.m34 = PERSPECTIVE
        
        model.toView.layer.transform = viewToTransform!
        
        //创建阴影
        let fromShadow = self.addOpacityToView(model.fromView, color: UIColor.blackColor())
        let toShadow = self.addOpacityToView(model.toView, color: UIColor.blackColor())

        fromShadow.alpha = 0
        toShadow.alpha = 1
        model.containerView.addSubview(model.toView)
        
        
        UIView.animateWithDuration(self.animatorDuration, animations: {
            
                switch self.cubeDirecation{
                case .horizontal:
                    model.containerView.transform = CGAffineTransformMakeTranslation(-dir*model.containerView.frame.size.width/2, 0)
                    break
                case .vertical:
                     model.containerView.transform = CGAffineTransformMakeTranslation(0,-dir*model.containerView.frame.size.height/2)
                    break
                }
            
            model.fromView.layer.transform = viewFromTransform!
            model.toView.layer.transform = CATransform3DIdentity
            
            fromShadow.alpha = 1
            toShadow.alpha = 0
            }) { (finished) in
                
                //恢复最初的位置
                model.containerView.transform = CGAffineTransformIdentity
                model.toView.layer.transform = CATransform3DIdentity
                model.fromView.layer.transform = CATransform3DIdentity
                //设置锚点为中心
                model.fromView.layer.anchorPoint = CGPointMake(0.5, 0.5)
                model.toView.layer.anchorPoint = CGPointMake(0.5, 0.5)
                
                //移除阴影
                fromShadow.removeFromSuperview()
                toShadow.removeFromSuperview()
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())

        }
    }
    
    
    func addOpacityToView(view:UIView,color:UIColor) -> UIView {
        let shadowView = UIView(frame: view.bounds)
        shadowView.backgroundColor = color.colorWithAlphaComponent(0.8)
        view.addSubview(shadowView)
        return shadowView
    }
    
}









