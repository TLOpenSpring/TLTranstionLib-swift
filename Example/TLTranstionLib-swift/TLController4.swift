//
//  TLController4.swift
//  TLTranstionLib-swift
//
//  Created by Andrew on 16/5/16.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class TLController4: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.whiteColor()
        self.title="页面4";
        initView()
        setRootRightBarItem()
    }
    
    
    func initView() -> Void {
        let iv=UIImageView(frame: CGRectMake(0, 64, 320, 400))
        iv.image=UIImage(named: "4")
        self.view.addSubview(iv)
        
        
    }
    
    func setRootRightBarItem() -> Void {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "回到首页", style: .Plain, target: self, action: #selector(TLController4.goRoot))
    }
    
    func goRoot()  {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

}
