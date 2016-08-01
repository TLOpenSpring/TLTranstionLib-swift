//
//  TLCoverVerticalAnimator.swift
//  Pods
//
//  Created by Andrew on 16/5/31.
//
//

import UIKit

public class TLCoverVerticalAnimator: TLBaseAnimator {
    
    enum TLCoverDirection {
        case fromTop
        case fromBotton
    }
    
    var tldirection:TLCoverDirection = .fromTop
    
    
    var snapshots:[TLSnapshotModel] = [TLSnapshotModel]()
    

    public override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let model = TransitionModel(context: transitionContext)
        
        if(self.operaiton == .Push){
            pushOperation(model, context: transitionContext)
        }else if(self.operaiton == .Pop){
            popOperation(model, context: transitionContext)
        }else{
            super.animateTransition(transitionContext)
        }
    }
    
    
    override func pushOperation(model: TransitionModel, context: UIViewControllerContextTransitioning) {
        
        let keyWindow = model.fromView.window
        let baseView = keyWindow?.subviews.first
        
        let originColor = keyWindow?.backgroundColor
        let newColor = model.toView.backgroundColor
        
        let ratio = 0.5
        let offset:CGFloat = 4
        
        keyWindow?.backgroundColor = newColor
        //屏幕截图
        let snapshotView = baseView?.snapshotViewAfterScreenUpdates(false)
        snapshotView?.frame = (baseView?.frame)!
        
        keyWindow?.addSubview(snapshotView!)
        keyWindow?.bringSubviewToFront(baseView!)
        
        
        //把目标view添加到容器中
        model.containerView.addSubview(model.toView)
        
        let originFrame = baseView?.frame
        var newFrame = baseView?.frame
        if(self.tldirection == TLCoverDirection.fromTop){
          newFrame?.origin.y -= (newFrame?.size.height)!
        }else if(self.tldirection == TLCoverDirection.fromBotton){
          newFrame?.origin.y += (newFrame?.size.height)!
        }
        
        baseView?.frame = newFrame!
        
        UIView.animateWithDuration(self.animatorDuration, animations: {
            
            var frame = snapshotView?.frame
            if self.tldirection == TLCoverDirection.fromTop{
             frame?.origin.y += (frame?.size.height)!
            }else if(self.tldirection == TLCoverDirection.fromTop){
              frame?.origin.y -= (frame?.size.height)!
            }
            
            snapshotView?.frame = frame!
            
            frame = originFrame
            if self.tldirection == TLCoverDirection.fromTop{
                frame?.origin.y += offset
            }else if(self.tldirection == TLCoverDirection.fromTop){
                frame?.origin.y -= offset
            }
            baseView?.frame = frame!
            
            }) { (finished) in
                UIView.animateWithDuration(self.animatorDuration*(1-ratio), animations: {
                    //恢复原状
                    baseView?.frame = originFrame!
                    
                    }, completion: { (finished) in
                      keyWindow?.backgroundColor = originColor
                        snapshotView?.removeFromSuperview()
                        
                        var snapshot:TLSnapshotModel?
                        for item in self.snapshots{
                            if item == model.fromViewController{
                             snapshot = item
                                break
                            }
                        }
                        if snapshot != nil{
                          snapshot?.snapshotView = snapshotView
                        }else{
                         snapshot = TLSnapshotModel()
                            snapshot?.viewConcroller = model.fromViewController
                            snapshot?.snapshotView = snapshotView
                            self.snapshots.append(snapshot!)
                            context.completeTransition(!context.transitionWasCancelled())
                        }
                })
        }
    }
    
    override func popOperation(model: TransitionModel, context: UIViewControllerContextTransitioning) {
        
//        print("model.fromViewController:\(model.fromViewController)")
//        print("model.toViewController:\(model.toViewController)")
        
        let keyWindow = model.fromView.window
        let baseView = keyWindow?.subviews.first!
        
        
        let originColor = keyWindow?.backgroundColor
        let newColor = model.toView.backgroundColor
        
        let offset:CGFloat = 4
        
        var result:TLSnapshotModel?
        
        
        snapshots = self.snapshots.reverse()
        for item in 0...snapshots.count-1{
           let snapshot = snapshots[item]
            if snapshot.viewConcroller == model.toViewController{
             result = snapshot
                break;
            }
        }
        
        if result != nil{
            snapshots = self.snapshots.reverse()
            let index = self.snapshots.indexOf(result!)
            let range:Range = Range(start: index!, end: self.snapshots.count-1)
            self.snapshots.removeRange(range)
            
            if result?.snapshotView?.frame.size.width == baseView?.frame.size.height || result?.snapshotView?.frame.size.height == baseView?.frame.size.width {
             result = nil
            }
        }
        if result != nil{
            keyWindow?.backgroundColor = newColor
            let snapshotView = result?.snapshotView
            keyWindow?.addSubview(snapshotView!)
            
            let originFrame = baseView?.frame
            var newFrame = baseView?.frame
            if tldirection == TLCoverDirection.fromTop{
                newFrame?.origin.y += (newFrame?.size.height)!
            }else if(tldirection == TLCoverDirection.fromBotton){
                newFrame?.origin.y -= (newFrame?.size.height)!
            }
            
            //snapshotView?.frame = newFrame!
            
            UIView.animateWithDuration(self.animatorDuration, animations: {
                
                var frame = baseView?.frame
                if self.tldirection == TLCoverDirection.fromTop{
                   frame!.origin.y -= newFrame!.size.height;
                }else if(self.tldirection == TLCoverDirection.fromBotton){
                  frame!.origin.y += newFrame!.size.height;
                }
                
                baseView?.frame = frame!
                
                frame = originFrame
                if self.tldirection == TLCoverDirection.fromTop{
                    frame!.origin.y -= offset
                }else if(self.tldirection == TLCoverDirection.fromBotton){
                    frame!.origin.y += offset
                }
                snapshotView?.frame = frame!
                
                }, completion: { (finished) in
                    
                    UIView.animateWithDuration(self.animatorDuration*(0.5), animations: {
                        snapshotView?.frame = originFrame!
                        }, completion: { (finished) in
                            keyWindow?.backgroundColor = originColor
                            baseView?.frame = originFrame!
                            
                            model.containerView.addSubview(model.toView)
                            
                            snapshotView?.removeFromSuperview()
                            context.completeTransition(!context.transitionWasCancelled())
                    })
            })
            
        }
        
    }
}




