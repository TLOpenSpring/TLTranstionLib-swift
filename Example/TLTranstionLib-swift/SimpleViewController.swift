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
        
    }
    
    func initView() -> Void {
        
        let btn = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 50))
        btn.setTitle("返回", forState: .Normal)
        btn.setTitleColor(UIColor.redColor(), forState: .Normal)
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(returnAction), forControlEvents: .TouchUpInside)
    }
    
    func returnAction() -> Void {
       self.dismissViewControllerAnimated(true, completion: nil)
    }
  
}
