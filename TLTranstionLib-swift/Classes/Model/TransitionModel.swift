//
//  TransitionModel.swift
//  Pods
//
//  Created by Andrew on 16/5/9.
//
//

import UIKit

class TransitionModel: NSObject {
    let  toViewController:UIViewController!;
    let  fromViewController:UIViewController!;
    let  toView:UIView!;
    let  fromView:UIView!;
    /**
     *  容器视图
     */
    let  containerView:UIView!;
    /**
     *  转场动画结束后的frame
     */
    let  finalFrameForToVC:CGRect!;
    
  
    
    init(context:UIViewControllerContextTransitioning) {
        self.toViewController=context.viewControllerForKey(UITransitionContextToViewControllerKey);
        self.fromViewController=context.viewControllerForKey(UITransitionContextFromViewControllerKey);
        self.fromView=fromViewController.view;
        self.toView=toViewController.view;
        self.containerView=context.containerView();
        
        
        let finalFromToVc=context.finalFrameForViewController(self.toViewController);
        self.toView.frame=finalFromToVc;
        self.toView .layoutIfNeeded();
        
        self.finalFrameForToVC=finalFromToVc;
        
    }
    
    
   
}
