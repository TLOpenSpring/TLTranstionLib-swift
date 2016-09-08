//
//  TabBarControllerViewController.swift
//  TLTranstionLib-swift
//
//  Created by Andrew on 16/7/22.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import TLTranstionLib_swift

class TabBarControllerViewController: UITabBarController {
    
    
    var tlCardAnimator:TLCardAnimator!
    
    var pushPopInteractionController: TLTransitionInteractionProtocol?
    var presentInteractionController: TLTransitionInteractionProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTabBarController()
      
    }
    
    /**
     初始化手势交互
     */
    func initInteraction() -> Void{
      
    }
    
 
    
    func initTabBarController() -> Void {
        
        
        let vc1 = TabViewController1()
        let vc2 = TabViewController2()
        let vc3 = TabViewController3()
        let vc4 = TabViewController4()
        
        
        let nav1 = UINavigationController()
        nav1.pushViewController(vc1, animated: true)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        
      
        
        let item1 = getTabItem(title: "首页", image: UIImage(named: "DT_menu1"))
        let item2 = getTabItem(title: "效果列表", image: UIImage(named: "DT_menu2"))
        let item3 = getTabItem(title: "Tab3", image: UIImage(named: "DT_menu3"))
        let item4 = getTabItem(title: "Tab4", image: UIImage(named: "DT_menu4"))
        
        vc1.tabBarItem = item1
        vc2.tabBarItem = item2
        vc3.tabBarItem = item3
        vc4.tabBarItem = item4
        
        self.setViewControllers([nav1,nav2,nav3,nav4], animated: true)
        
        self.delegate = TLTransitionManager.shared()
        
        self.tabBar.barTintColor = UIColor.lightGrayColor()
        self.tabBarController?.delegate = TLTransitionManager.shared()
    }
    
    func getTabItem(title title:String,image:UIImage?) -> UITabBarItem {
        let item = UITabBarItem(title: title, image: image, tag:0)
        
        let font = UIFont.systemFontOfSize(12)
        
        let attributes = [NSForegroundColorAttributeName:UIColor.redColor(),
                          NSFontAttributeName:font
                          ]
        
        let attributesActivte = [NSForegroundColorAttributeName:UIColor.redColor(),
                                 NSFontAttributeName:font
                          ]
        
        item.setTitleTextAttributes(attributes, forState: .Normal)
        item.setTitleTextAttributes(attributesActivte, forState: .Selected)
    
        return item
    }
    
    //MARK: - TLTransitionInteractionControllerDelegate
    
    
  }

















