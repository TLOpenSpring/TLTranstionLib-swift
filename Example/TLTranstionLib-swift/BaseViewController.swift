//
//  BaseViewController.swift
//  TLTranstionLib-swift
//
//  Created by Andrew on 16/5/16.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var navView:UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initNavBar()
        hideNavView()
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title: "下一步", style:.Plain, target: self, action: #selector(BaseViewController.nextStep(_:)))
    }
    
    func nextStep(sender:AnyObject) -> Void {
        let vc=getCurrentVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getCurrentVC() ->UIViewController{
        return UIViewController()
    }
    
    
    func showNavView() -> Void {
        navView.hidden = false
    }
    
    func hideNavView() -> Void {
        navView.hidden = true
    }
    
    func initNavBar() -> Void {
        var  rect = CGRect(x: 0, y: 0, width: screen_width, height: 64)
        navView = UIView(frame: rect)
        navView.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(navView)
        
        
        rect = CGRect(x: 0, y: 10, width: 50, height: 50)
        let btn = UIButton(frame: rect)
        btn.setTitleColor(UIColor.redColor(), forState: .Normal)
        btn.setTitle("返回", forState: .Normal)
        navView.addSubview(btn)
        
        btn.addTarget(self, action: #selector(returnAction(_:)), forControlEvents: .TouchUpInside)
    }
    
    func returnAction(btn:UIButton) -> Void {
        
        if self.navigationController == nil{
            self.dismissViewControllerAnimated(true, completion: nil)
        }else{
          self.navigationController?.popViewControllerAnimated(true)
        }
    }

}
