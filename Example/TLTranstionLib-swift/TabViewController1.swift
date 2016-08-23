//
//  TabViewController1.swift
//  TLTranstionLib-swift
//
//  Created by Andrew on 16/7/22.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import TLTranstionLib_swift

class TabViewController1: BaseTabController,TLTransitionInteractionControllerDelegate {
    
    var pushPopInteractionController: TLTransitionInteractionProtocol?
    var presentInteractionController: TLTransitionInteractionProtocol?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "TabViewController1"
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.tabBarItem.title = "tab1"
        
        self.navigationController?.delegate = TLTransitionManager.shared()
        
        TLTransitionManager.shared().defaultPresentDismissAnimation = TLCardAnimator()
        
        TLTransitionManager.shared().defaultPushPopAnimation = TLCardSliderAnimator()
        
        
        
        
        initView()
        initInteraction()
        
        initAnimation()
        
    }
    /**
     初始化手势交互
     */
    func initInteraction() -> Void{
        pushPopInteractionController = TLHorizontalInteraction()
        pushPopInteractionController?.nextControllerDelegate = self
        pushPopInteractionController?.attachViewController(viewController: self, action: TLTranstionAction.tl_PushPop)
        
        TLTransitionManager.shared().tl_setInteraction(interactionController: pushPopInteractionController!, fromController: self.dynamicType, toController: nil, action: .tl_PushPop)
    }
    
    func initAnimation() -> Void {
        
        TLTransitionManager.shared().tl_setAnimation(animation: TLCardSliderAnimator(), fromViewController: self.dynamicType, action: .tl_PushPop)
        
        
        
        TLTransitionManager.shared().tl_setAnimation(animation: TLCardAnimator(), fromViewController: self.dynamicType, action: .tl_PresentDismiss)
        
        
        TLTransitionManager.shared().tl_setAnimation(animation: TLDivideAnimator(), fromViewController: self.dynamicType, toViewController: nil, action: TLTranstionAction.tl_Tab)
        
    }
    
    
    func initView() -> Void {
        var rect = CGRect(x: 100, y: 100, width: 200, height: 50)
        let btn = UIButton(frame: rect)
        btn.setTitle("跳页面->present", forState: .Normal)
        btn.setTitleColor(UIColor.blueColor(), forState: .Normal)
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(skip(_:)), forControlEvents: .TouchUpInside)
        
        
         rect = CGRect(x: 100, y: CGRectGetMaxY(btn.frame)+10, width: 200, height: 50)
        let btn1 = UIButton(frame: rect)
        btn1.setTitle("跳页面->push", forState: .Normal)
        btn1.setTitleColor(UIColor.blueColor(), forState: .Normal)
        self.view.addSubview(btn1)
        btn1.addTarget(self, action: #selector(skipPush(_:)), forControlEvents: .TouchUpInside)
    }
    
    func skipPush(btn:UIButton) -> Void {
        let simple = TLNavController()
        simple.transitioningDelegate = TLTransitionManager.shared()
        simple.navigationController?.delegate = TLTransitionManager.shared()
        self.navigationController?.pushViewController(simple, animated: true)
    }
    
    func skip(btn:UIButton) -> Void {
        let simple = SimpleViewController()
        simple.transitioningDelegate = TLTransitionManager.shared()
        TLTransitionManager.shared().tl_setAnimation(animation: TLCardAnimator(), fromViewController: SimpleViewController.self, action: .tl_Dismiss)
        self.presentViewController(simple, animated: true, completion: nil)
    }
    //MARK: - TLTransitionInteractionControllerDelegate
    func nextViewControllerForInteractor(interactor: TLTransitionInteractionProtocol) -> UIViewController {
        
        let simple = SimpleViewController()
        return simple
    }


}
