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
    
    let operaiton:UINavigationControllerOperation?
    
   
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
    
        return animatorDuration;
    }
    
    /**
     具体动画执行的代码
     
     - parameter transitionContext: 动画上下文
     */
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning){
     
    }
    
}


