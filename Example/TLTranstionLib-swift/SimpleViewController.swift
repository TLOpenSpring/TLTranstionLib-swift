//
//  SimpleViewController.swift
//  TLTranstionLib-swift
//
//  Created by Andrew on 16/8/16.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import TLTranstionLib_swift

class SimpleViewController: BaseTabController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SimpleViewController"
        self.view.backgroundColor = UIColor.yellowColor()
        
        initView()
        
        self.navigationController?.delegate = TLTransitionManager.shared()
    }
    
    func initView() -> Void {
        let item = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancelAction))
        self.navigationItem.leftBarButtonItem = item
        
        
        
        let btn = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 50))
        btn.setTitle("返回", forState: .Normal)
        btn.setTitleColor(UIColor.redColor(), forState: .Normal)
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(returnAction), forControlEvents: .TouchUpInside)
    }
    
    func returnAction() -> Void {
       self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func cancelAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}