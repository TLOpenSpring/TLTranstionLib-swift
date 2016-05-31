//
//  TLFromLeftAnimator.swift
//  Pods
//
//  Created by Andrew on 16/5/31.
//
//

import UIKit

public class TLFromLeftAnimator: TLBaseAnimator {

    var snapshots:NSMutableArray!
    
    let TAGKEY = 9999
    
//    func snapshots() -> NSMutableArray {
//        if(snapshots==nil){
//         snapshots = NSMutableArray()
//        }
//        return snapshots
//        
//    }
    
    public override init() {
        super.init()
        
        if(snapshots == nil){
           snapshots = NSMutableArray()
        }
    }
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
    
    /**
     结论
     当执行 model.containerView.addSubview(model.toView)这行代码的时候
     model.fromView的概念就会消失，就是没有fromView了。
     如果屏幕截图 不管是用 fromView还是toView截图，最后得到的截图都是TOView的屏幕截图。
     
     
     
     - parameter model:   <#model description#>
     - parameter context: <#context description#>
     */
    func popOpreation(model:TransitionModel,context:UIViewControllerContextTransitioning) -> Void {
        
        let keyWindow = model.fromView.window
        let baseView = keyWindow?.subviews.first
        
        var result : TLSnapshotModel?
        
        for var i = self.snapshots.count-1;i>=0;i-- {
            let snapshot = self.snapshots[i] as! TLSnapshotModel
            if(snapshot.viewConcroller == model.toViewController){
                result = snapshot
                break
            }
        }
        
        if(result != nil){
           let index = self.snapshots.indexOfObject(result!)
            self.snapshots.removeObjectsInRange(NSMakeRange(index, self.snapshots.count-index))
        }
        
        if(result != nil){
            //获取之前的屏幕截图
          let snapshotView = result?.snapshotView
          let maskView = snapshotView?.viewWithTag(TAGKEY)
            
            keyWindow?.addSubview(snapshotView!)
            keyWindow?.bringSubviewToFront(baseView!)
            
            let originalFrame = baseView?.frame
            var newFrame = baseView?.frame
            newFrame?.origin.x = (newFrame?.origin.x)! + (newFrame?.size.width)!
            
            
            UIView.animateWithDuration(self.animatorDuration, animations: {
                
                maskView?.alpha = 0
                snapshotView?.layer.transform = CATransform3DIdentity
                baseView?.frame = newFrame!
                
                }, completion: { (finished) in
                    
                    baseView?.frame = originalFrame!
                    model.containerView.addSubview(model.toView)
                    snapshotView?.removeFromSuperview()
                    context.completeTransition(!context.transitionWasCancelled())
            })
            
        }
        
    }
    
    func pushOpreation(model:TransitionModel,context:UIViewControllerContextTransitioning) -> Void {
        
        
        let keyWindow = model.fromView.window
        var baseView = keyWindow?.subviews.first
        
        
        //获取屏幕快照
        let snapshotView = baseView?.snapshotViewAfterScreenUpdates(false)
        snapshotView?.frame = (baseView?.frame)!
        
//        let maskView = UIView(frame: (snapshotView?.bounds)!)
//        maskView.alpha = 0
//        maskView.tag = TAGKEY
//        snapshotView?.addSubview(maskView)
        
        
  
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
            //添加目标视图
            model.containerView.addSubview(model.toView)
           // maskView.alpha = 0.35
            
            }) { (finished) in
                snapshotView?.removeFromSuperview()
                
                var snapShot:TLSnapshotModel?
                
                for sp  in self.snapshots {
                   let spShot = sp as! TLSnapshotModel
                    if(spShot.viewConcroller  == model.fromViewController){
                        snapShot = spShot
                        break;
                    }
                }
                
                if(snapShot != nil){
                    //设置屏幕快照
                    snapShot?.snapshotView = snapshotView
                }else{
                    snapShot = TLSnapshotModel()
                    snapShot?.snapshotView=snapshotView
                    snapShot?.viewConcroller = model.fromViewController
                    self.snapshots.addObject(snapShot!)
                }
                context.completeTransition(!context.transitionWasCancelled())
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
