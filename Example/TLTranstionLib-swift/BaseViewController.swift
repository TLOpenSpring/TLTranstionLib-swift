//
//  BaseViewController.swift
//  TLTranstionLib-swift
//
//  Created by Andrew on 16/5/16.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title: "下一步", style:.Plain, target: self, action: #selector(BaseViewController.nextStep(_:)))
    }
    
    func nextStep(sender:AnyObject) -> Void {
        let vc=getCurrentVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getCurrentVC() ->UIViewController{
        return UIViewController()
    }

}
