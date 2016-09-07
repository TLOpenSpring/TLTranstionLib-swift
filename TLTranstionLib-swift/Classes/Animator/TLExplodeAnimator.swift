//
//  TLExplodeAnimator.swift
//  Pods
//  爆炸效果
//  Created by Andrew on 16/5/31.
//
//

import UIKit

public class TLExplodeAnimator: TLBaseAnimator {


    public override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let model = TransitionModel(context: transitionContext)
        
        model.containerView.addSubview(model.toView)
        model.containerView.sendSubviewToBack(model.toView)
        
        let size = model.toView.frame.size
        
        var snapshots = [UIView]()
        
        let xFactor:CGFloat = 20
        let yFactor = xFactor * size.height / size.width;
        //开始屏幕截图
        var fromViewSnapshot : UIView!
        
        //如果是UINavigation的push操作
        if self.showType == .push || showType == .pop {
            fromViewSnapshot = model.fromView.snapshotViewAfterScreenUpdates(false)
        }else if self.showType == .present || showType == .dismiss{
            //那就一定是使用UIViewController的 Present方式
            fromViewSnapshot = model.fromView.snapshotViewAfterScreenUpdates(true)
        }
        
        //创建屏幕截图的每个爆炸碎片
        for (var x:CGFloat = 0; x<size.width; x=x+size.width/xFactor) {
            for (var y:CGFloat = 0; y<size.height; y+=size.height/yFactor) {
                
                var snapshotRegion = CGRectMake(x, y, size.width/xFactor, size.height/yFactor);
                
                var flag = false
                if self.showType == .push{
                  flag = false
                }else if showType == .present
                {
                  flag = true
                }
                
                var snapshot = fromViewSnapshot.resizableSnapshotViewFromRect(snapshotRegion, afterScreenUpdates: flag, withCapInsets:UIEdgeInsetsZero)
                
                
                snapshot.frame = snapshotRegion;
                model.containerView.addSubview(snapshot)
                snapshots.append(snapshot)
            }
        }
        
        
        model.containerView.sendSubviewToBack(model.fromView)
        
        
        let duration = self.animatorDuration
        
        UIView.animateWithDuration(duration, animations: {
            
            for item in snapshots{
              let xOffset = self.randomFloatBetween(-100, bigNumber: 100)
                let yOffset = self.randomFloatBetween(-100, bigNumber: 100)
                item.frame = CGRectOffset(item.frame, xOffset, yOffset)
                item.alpha = 0
                
                let transform =  CGAffineTransformMakeRotation(self.randomFloatBetween(-10, bigNumber: 10))
                item.transform = CGAffineTransformScale(transform, 0.01, 0.01)
            }
            
            }) { (finished) in
                
                for item in snapshots{
                 item.removeFromSuperview()
                }
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                
        }
    }
    
    
    func randomFloatBetween(smallNumber:Float,bigNumber:Float) -> CGFloat {
        var diff = bigNumber - smallNumber;
      
        let result = (((Float) (Float(arc4random()) % (Float(RAND_MAX) + 1)) / Float(RAND_MAX)) * diff) + smallNumber;
     return CGFloat(result)
    }
    
}











