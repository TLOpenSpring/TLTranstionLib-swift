//
//  TabViewController2.swift
//  TLTranstionLib-swift
//
//  Created by Andrew on 16/7/22.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import TLTranstionLib_swift

class TabViewController2: BaseTabController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "TabViewController2"
        self.view.backgroundColor = UIColor.brownColor()
        
        self.navigationController?.delegate = TLTransitionManager.shared()
        initAnimation()
    }
    
    func initAnimation() -> Void {
        TLTransitionManager.shared().tl_setAnimation(animation: TLCardSliderAnimator(), fromViewController: self.dynamicType, toViewController: nil, action: TLTranstionAction.tl_Tab)
    }

 

}
