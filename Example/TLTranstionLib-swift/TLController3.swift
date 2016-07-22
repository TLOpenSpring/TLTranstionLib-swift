//
//  TLController3.swift
//  TLTranstionLib-swift
//
//  Created by Andrew on 16/5/16.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class TLController3: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.whiteColor()
        self.title="页面3";
        
        initView()
    }
    
    
    func initView() -> Void {
        let iv=UIImageView(frame: CGRectMake(0, 20, screen_width, sceeen_height))
        iv.image=UIImage(named: "3")
        iv.contentMode = .ScaleAspectFit
        self.view.addSubview(iv)
        
    }

    override func getCurrentVC() -> UIViewController {
        return TLController4()
    }
}
