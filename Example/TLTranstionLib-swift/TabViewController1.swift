//
//  TabViewController1.swift
//  TLTranstionLib-swift
//
//  Created by Andrew on 16/7/22.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import TLTranstionLib_swift

class TabViewController1: BaseTabController {
    
    var pushPopInteractionController: TLTransitionInteractionProtocol?
    var presentInteractionController: TLTransitionInteractionProtocol?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "TabViewController1"
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        self.navigationController?.delegate = TLTransitionManager.shared()

        initView()
        initAnimator()
        self.tabBarController?.delegate = TLTransitionManager.shared()
    }
    /**
     初始化手势交互
     */
    func initInteraction() -> Void{
//        pushPopInteractionController = TLHorizontalInteraction()
//        pushPopInteractionController?.nextControllerDelegate = self
//        pushPopInteractionController?.attachViewController(viewController: self, action: TLTranstionAction.tl_PushPop)
//        
//        TLTransitionManager.shared().tl_setInteraction(interactionController: pushPopInteractionController!, fromController: self.dynamicType, toController: nil, action: .tl_PushPop)
    }
    
    
    func initAnimator() -> Void {
//        TLTransitionManager.shared().tl_setAnimation(animation: TLDivideAnimator(), fromViewController: self.dynamicType, toViewController: nil, action: .tl_Tab)
        
       
        
        
    }

    
    
    func initView() -> Void {
        var rect = CGRect(x: 100, y: 100, width: 200, height: 50)
        let btn = createBtn(rect, title: "跳到页面1->presen")
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(skipView1(_:)), forControlEvents: .TouchUpInside)
        
        rect = CGRect(x: 100, y: CGRectGetMaxY(btn.frame)+5, width: 200, height: 50)
        let btn1 = createBtn(rect, title: "跳到页面2->present")
        self.view.addSubview(btn1)
        btn1.addTarget(self, action: #selector(skip(_:)), forControlEvents: .TouchUpInside)
        
        rect = CGRect(x: 100, y: CGRectGetMaxY(btn1.frame)+20, width: 200, height: 50)
        let btn2 = createBtn(rect, title: "跳到页面2->Push")
        self.view.addSubview(btn2)
        btn2.addTarget(self, action: #selector(skipPush1(_:)), forControlEvents: .TouchUpInside)
        
        rect = CGRect(x: 100, y: CGRectGetMaxY(btn2.frame)+5, width: 200, height: 50)
        let btn3 = createBtn(rect, title: "跳到页面2->Push")
        self.view.addSubview(btn3)
        btn3.addTarget(self, action: #selector(skipPush2(_:)), forControlEvents: .TouchUpInside)
        
        
        
    }
    
    func createBtn(rect:CGRect,title:String) -> UIButton {
        let btn = UIButton(frame: rect)
        btn.setTitle(title, forState: .Normal)
        btn.setTitleColor(UIColor.blueColor(), forState: .Normal)
        btn.backgroundColor = UIColor.lightGrayColor()
        return btn
    }
    
    
    func skipPush1(btn:UIButton) -> Void {
        
        TLTransitionManager.shared().tl_setAnimation(animation: TLDivideAnimator(), fromViewController: TabViewController1.self, toViewController: TLNavController.self, action: .tl_PushPop)
        
        let simple = TLNavController()
        self.navigationController?.pushViewController(simple, animated: true)
    }
    
    func skipPush2(btn:UIButton) -> Void {
        
        TLTransitionManager.shared().tl_setAnimation(animation: TLCardAnimator(), fromViewController: TabViewController1.self, toViewController: SimpleViewController.self, action: .tl_PushPop)
        
        let simple = SimpleViewController()
        self.navigationController?.pushViewController(simple, animated: true)
    }
    
    func skip(btn:UIButton) -> Void {
         TLTransitionManager.shared().tl_setAnimation(animation: TLFromLeftAnimator(), fromViewController: TabViewController1.self, toViewController: SimpleViewController.self, action: .tl_PresentDismiss)
        
        let simple = SimpleViewController()
        simple.transitioningDelegate = TLTransitionManager.shared()
        self.presentViewController(simple, animated: true, completion: nil)
        
    }
    
    func skipView1(btn:UIButton) -> Void {
       
        
        TLTransitionManager.shared().tl_setAnimation(animation: TLDivideAnimator(), fromViewController: TabViewController1.self, toViewController: TLNavController.self, action: .tl_PresentDismiss)
        
        let nav = TLNavController()
        nav.transitioningDelegate = TLTransitionManager.shared()
        self.presentViewController(nav, animated: true, completion: nil)

    }


}
