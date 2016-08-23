//
//  TLDivideAnimator.swift
//  Pods
//
//  Created by Andrew on 16/5/31.
//
//

import UIKit

public class TLDivideAnimator: TLBaseAnimator {

    var snapshots = [TLSnapshotModel]()
    
    
    public override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let model = TransitionModel(context: transitionContext)
        
        if self.isPositiveAnimation == true{
          pushOperation(model, context: transitionContext)
        }else{
          popOperation(model, context: transitionContext)
        }
        
    }
    
    override func pushOperation(model: TransitionModel, context: UIViewControllerContextTransitioning) {
        let baseView = model.fromView.window?.subviews.first
        
        let width = baseView?.bounds.width
        let height = baseView?.bounds.height
        
        let position = height!/2
        var topFrame = CGRectMake(0, 0, width!, position)
        var bottomFrame = CGRectMake(0, position, width!, height! - position)
        //获取上边的屏幕截图
        let snapshotTop = baseView?.resizableSnapshotViewFromRect(topFrame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
        
        //获取下边的屏幕截图
        let snapshotBottom = baseView?.resizableSnapshotViewFromRect(bottomFrame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
        
        snapshotTop?.frame = topFrame
        snapshotBottom?.frame = bottomFrame
        baseView?.addSubview(snapshotTop!)
        baseView?.addSubview(snapshotBottom!)
        
        model.containerView.addSubview(model.toView)
        
        //初始化Y轴坐标
        //让上边的截图移动到屏幕上边
        topFrame.origin.y -= topFrame.height
        //让下边的截图移动到屏幕的下边
        bottomFrame.origin.y += bottomFrame.height
        
        UIView.animateWithDuration(self.animatorDuration, animations: {
            snapshotTop?.frame = topFrame
            snapshotTop?.alpha = 0
            
            snapshotBottom?.frame = bottomFrame
            snapshotBottom?.alpha = 0
            }) { (finished) in
                
                snapshotBottom?.removeFromSuperview()
                snapshotTop?.removeFromSuperview()
                
                var snapshot:TLSnapshotModel?
                for item in self.snapshots{
                    if item.viewConcroller == model.fromViewController{
                     snapshot = item
                        break
                    }
                }
                if snapshot != nil{
                    snapshot?.snapshotTopView = snapshotTop
                    snapshot?.snapshotBottomView = snapshotBottom
                }else{
                  snapshot = TLSnapshotModel()
                    snapshot?.viewConcroller = model.fromViewController
                    snapshot?.snapshotBottomView = snapshotBottom
                    snapshot?.snapshotTopView = snapshotTop
                    self.snapshots.append(snapshot!)
                }
                
                context.completeTransition(!context.transitionWasCancelled())
                
        }
        
        
        
        
    }
    
    override func popOperation(model: TransitionModel, context: UIViewControllerContextTransitioning) {
        let baseView = model.fromView.window?.subviews.first
        
        let width = baseView?.bounds.width
        let height = baseView?.bounds.height
        
        let position = height!/2
        var topFrame = CGRectMake(0, 0, width!, position)
        var bottomFrame = CGRectMake(0, position, width!, height! - position)
        
        var result:TLSnapshotModel?
         //倒序，依次把Navigationcontroller栈中的控制器移除
        snapshots = snapshots.reverse()
        for item in snapshots {
            if item.viewConcroller == model.toViewController{
             result = item
                break
            }
        }
        //重置为正常顺序
        snapshots = snapshots.reverse()
        if result != nil{
           let index = snapshots.indexOf(result!)
            
            let range = Range(start: index!, end: snapshots.count-1)
            self.snapshots.removeRange(range)
        }
        
        if result != nil{
         
            let snotshotTop = result?.snapshotTopView
            let snotshotBottom = result?.snapshotBottomView
            var topFrame = snotshotTop?.frame
            var bottomFrame = snotshotBottom?.frame
            snotshotTop?.alpha = 0
            snotshotBottom?.alpha = 0
            
            baseView?.addSubview(snotshotBottom!)
            baseView?.addSubview(snotshotTop!)
            
            topFrame?.origin.y  = 0
            bottomFrame?.origin.y = height! - (bottomFrame?.height)!

            UIView.animateWithDuration(self.animatorDuration, animations: {
                snotshotTop?.frame = topFrame!
                snotshotBottom?.frame = bottomFrame!
                
                snotshotBottom?.alpha = 1
                snotshotTop?.alpha = 1
                
                }, completion: { (finished) in
                    
                    model.containerView.addSubview(model.toView)
                    
                    snotshotTop?.removeFromSuperview()
                    snotshotBottom?.removeFromSuperview()
                    
                    context.completeTransition(!context.transitionWasCancelled())
                    
            })
        }
    }
}
















