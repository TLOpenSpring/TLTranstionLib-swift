//
//  TLTransitionNavigationController.swift
//  Pods
//
//  Created by Andrew on 16/8/16.
//
//

import UIKit

public class TLTransitionNavigationController: UINavigationController,UIGestureRecognizerDelegate {

    override public func viewDidLoad() {
        super.viewDidLoad()
        weak var weakSelf = self
        
        self.interactivePopGestureRecognizer?.enabled = true
        self.interactivePopGestureRecognizer?.delegate = weakSelf
        self.delegate = TLTransitionManager.shared()
        
        
    }

}
