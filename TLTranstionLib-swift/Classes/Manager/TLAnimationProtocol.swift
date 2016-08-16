//
//  TLAnimationProtocol.swift
//  Pods
//
//  Created by Andrew on 16/8/5.
//
//

import Foundation
import UIKit
/**
 *  动画效果的协议
 */
public protocol TLAnimationProtocol:UIViewControllerAnimatedTransitioning{
    
    /**
     * If the animation should be positive or negative.
     *
     * @note Positive: push / present / fromTop / toRight
     * @note Negative: pop / dismiss / fromBottom / toLeft
     */
    var isPositiveAnimation:Bool{
        get
        set
    }
}
/**
 *  手势交互效果的协议
 */
public protocol TLTransitionInteractionProtocol:UIViewControllerInteractiveTransitioning {
    
    /// 当前用户是否可以交互
    var isInteractive:Bool{
        get
        set
    }
    /**
     *  Should the transition interaction controller complete the transaction if it is released in its current state.  Ex: a swipe interactor should not complete until it has passed a threshold percentage.
     */
    var shouldCompleteTransition:Bool{
        get
        set
    }
    /// 控制器的操作
    var action:TLTranstionAction{
        get
        set
    }
    /// 下一个控制器的代理
    var nextControllerDelegate:TLTransitionInteractionControllerDelegate?{
        get
        set
    }
    
    
    /**
     Initialize the Interaction Controller in the supplied @c UIViewController.  Typically adds a gesture recognizer to the @c UIViewController's view.
     - parameter viewController: 过渡动画的控制器
     - parameter action:         对控制器的页面操作
     
     - returns:
     */
    func attachViewController(viewController viewController:UIViewController,action:TLTranstionAction) -> Void
    
    
    
}




public protocol TLTransitionInteractionControllerDelegate {
    
    /**
     这个代理允许控制器去接收到一个UIViewController去展示
     当执行一个push或者present操作时
     
     - parameter interactor:
     
     - returns: 目标控制器
     */
    
   func nextViewControllerForInteractor(interactor:TLTransitionInteractionProtocol)->UIViewController


}












