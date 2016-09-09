//
//  TestViewController.swift
//  TLTranstionLib-swift
//
//  Created by Andrew on 16/9/9.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import TLTranstionLib_swift


class TestViewController: UIViewController,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orangeColor()
        // Do any additional setup after loading the view.
        initView()
        
        self.navigationController?.delegate = TLTransitionManager.shared()
        
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
        let animator = TLDivideAnimator()
        animator.animatorDuration = 1
        
        TLTransitionManager.shared().tl_setAnimation(animation: animator, fromViewController: self.dynamicType, action: .tl_PushPop)
        
        let simple = TLNavController()
        simple.transitioningDelegate = TLTransitionManager.shared()
        self.navigationController?.pushViewController(simple, animated: true)
    }
    
    func skip(btn:UIButton) -> Void {
        
        let animator = TLDivideAnimator()
        animator.animatorDuration = 0.5
        
        //        TLTransitionManager.shared().tl_setAnimation(animation: animator, fromViewController: self.dynamicType, action: .tl_PresentDismiss)
        
        TLTransitionManager.shared().tl_setAnimation(animation: animator, fromViewController: self.dynamicType, toViewController: SimpleViewController.self, action: .tl_PresentDismiss)
        
        let simple = SimpleViewController()
        simple.transitioningDelegate = TLTransitionManager.shared()
        self.presentViewController(simple, animated: true, completion: nil)
    }
  

}
