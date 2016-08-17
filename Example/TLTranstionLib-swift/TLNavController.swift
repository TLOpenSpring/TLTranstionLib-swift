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
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.navigationController?.delegate = TLTransitionManager.shared()
    }
}
