//
//  TLFromLeftAnimator.swift
//  Pods
//
//  Created by Andrew on 16/5/31.
//
//

import UIKit

public class TLFromLeftAnimator: TLBaseAnimator {

    var snapshots:NSMutableArray = NSMutableArray()
    
    let TAGKEY = 9999
    /**
     执行动画
     
     - parameter transitionContext: 上下文
     */
    public override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let model = TransitionModel(context: transitionContext)
        
        
        
        if(self.operaiton == .Push){
            pushOpreation(model, context: transitionContext)
            
        }else if(self.operaiton == .Pop){
            popOpreation(model, context: transitionContext)
        }else {
            super.animateTransition(transitionContext)
        }
    }
    
    
    func popOpreation(model:TransitionModel,context:UIViewControllerContextTransitioning) -> Void {
    }
    
    func pushOpreation(model:TransitionModel,context:UIViewControllerContextTransitioning) -> Void {
        
        let keyWindow = model.fromView.window
        let baseView = keyWindow?.subviews.first
        
        //获取屏幕快照
        let snapshotView = baseView?.snapshotViewAfterScreenUpdates(false)
        snapshotView?.frame = (baseView?.frame)!
        
        
        let maskView = UIView(frame: (snapshotView?.bounds)!)
        maskView.alpha = 0
        maskView.tag = TAGKEY
        snapshotView?.addSubview(maskView)
        
        
        //添加目标视图
        model.containerView.addSubview(model.toView)
        keyWindow?.addSubview(snapshotView!)
        keyWindow?.bringSubviewToFront(baseView!)
        
        
        let originalFrame = baseView?.frame
        var newFrame = baseView?.frame
        newFrame?.origin.x = (newFrame?.origin.x)! + (newFrame?.size.width)!
        baseView?.frame = newFrame!
        
        
        
        var transform : CATransform3D = CATransform3DIdentity
        transform.m34 = -1.0 / 750
        transform = CATransform3DTranslate(transform, 0, 0, -50)
        UIView.animateWithDuration(self.animatorDuration, animations: {
            
            baseView?.frame = originalFrame!
            snapshotView?.layer.transform = transform
            maskView.alpha = 0.35
            
            }) { (finished) in
                
                snapshotView?.removeFromSuperview()
                
                var snapshot:TLSnapshotModel?
                for sp in self.snapshots {
                    if (sp as! TLSnapshotModel) == model.fromViewController {
                        snapshot = sp as? TLSnapshotModel;
                        break;
                    }
                }
                
                if(snapshot != nil){
                    snapshot?.snapshotView = snapshotView
                }else{
                    snapshot = TLSnapshotModel()
                    snapshot?.snapshotView = snapshotView
                    snapshot?.viewConcroller = model.fromViewController
                    self.snapshots.addObject(snapshot!)
                }
                
                context.completeTransition(!context.transitionWasCancelled())
                
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
