//
//  TabBarControllerViewController.swift
//  TLTranstionLib-swift
//
//  Created by Andrew on 16/7/22.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import TLTranstionLib_swift

class TabBarControllerViewController: UITabBarController,TLTransitionInteractionControllerDelegate {
    
    
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
        pushPopInteractionController = TLHorizontalInteraction()
        pushPopInteractionController?.nextControllerDelegate = self
        pushPopInteractionController?.attachViewController(viewController: self, action: TLTranstionAction.tl_PushPop)
        
        TLTransitionManager.shared().tl_setInteraction(interactionController: pushPopInteractionController!, fromController: self.dynamicType, toController: nil, action: .tl_PushPop)
    }
    
    func initAnimation() -> Void {
        TLTransitionManager.shared().tl_setAnimation(animation: TLCardSliderAnimator(), fromViewController: self.dynamicType, action: .tl_PushPop)
        
        
        TLTransitionManager.shared().tl_setAnimation(animation: TLCardSliderAnimator(), fromViewController: self.dynamicType, action: .tl_PresentDismiss)
    }
    
    func initTabBarController() -> Void {
        
        
        let vc1 = TabViewController1()
        let vc2 = TabViewController2()
        let vc3 = TabViewController3()
        let vc4 = TabViewController4()
        
      
        
        vc1.tabBarItem = UITabBarItem(title: "Tab1", image: nil, tag: 0)
        vc2.tabBarItem = UITabBarItem(title: "Tab2", image: nil, tag: 1)
        vc3.tabBarItem = UITabBarItem(title: "Tab3", image: nil, tag: 2)
        vc4.tabBarItem = UITabBarItem(title: "Tab4", image: nil, tag: 3)
        
        self.setViewControllers([vc1,vc2,vc3,vc4], animated: true)
        
        self.delegate = TLTransitionManager.shared()
        
        
    }
    
    //MARK: - TLTransitionInteractionControllerDelegate
    
    func nextViewControllerForInteractor(interactor: TLTransitionInteractionProtocol) -> UIViewController {
        
        let simple = SimpleViewController()
        return simple
    }
    
  }

















