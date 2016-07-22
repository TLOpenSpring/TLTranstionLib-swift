//
//  BaseTabController.swift
//  TLTranstionLib-swift
//
//  Created by Andrew on 16/7/22.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class BaseTabController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let attr1 = getAttibutes()
        let attr2 = getActiveAttibutes()
        self.tabBarItem.setTitleTextAttributes(attr1, forState: .Normal)
        self.tabBarItem.setTitleTextAttributes(attr2, forState: .Selected)

        // Do any additional setup after loading the view.
    }

    func getAttibutes() -> [String:AnyObject] {
        let font = UIFont.systemFontOfSize(18)
        let attrs = [NSFontAttributeName:font,
                     NSForegroundColorAttributeName:UIColor.grayColor()]
        
        return attrs
    }
    
    func getActiveAttibutes() -> [String:AnyObject] {
        let font = UIFont.systemFontOfSize(18)
        let attrs = [NSFontAttributeName:font,
                     NSForegroundColorAttributeName:UIColor.redColor()]
        
        return attrs
    }

}
