//
//  TLController1.swift
//  TLTranstionLib-swift
//
//  Created by Andrew on 16/5/16.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class TLController1: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.blueColor()
        self.title="页面1";
        
        initView()
    }

    
    func initView() -> Void {
        let iv=UIImageView(frame: CGRectMake(0, 20, screen_width, sceeen_height))
        iv.image=UIImage(named: "1")
        iv.contentMode = .ScaleAspectFit
        self.view.addSubview(iv)
    
        
    }
    
    override func getCurrentVC() -> UIViewController {
        return TLController2()
    }
  

}
