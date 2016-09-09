//
//  TLNavController.swift
//  TLTranstionLib-swift
//
//  Created by Andrew on 16/8/16.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import TLTranstionLib_swift

class TLNavController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "TLNavController"
        self.view.backgroundColor = UIColor.redColor()
        
        self.navigationController?.delegate = TLTransitionManager.shared()
        
        let rect = CGRectMake(100, 100, 200, 50)
        
        let btn = UIButton(frame: rect)
        btn.center = self.view.center
        btn.setTitle("返回上个页面", forState:.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.view.addSubview(btn)
        
        btn.addTarget(self, action: #selector(returnPreviousView), forControlEvents: .TouchUpInside)
    }
    
    func returnPreviousView() -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
         self.navigationController?.popViewControllerAnimated(true)
    }
}
