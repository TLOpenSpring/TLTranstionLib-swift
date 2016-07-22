//
//  TabBarControllerViewController.swift
//  TLTranstionLib-swift
//
//  Created by Andrew on 16/7/22.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import TLTranstionLib_swift

class TabBarControllerViewController: UITabBarController,UITabBarControllerDelegate {
    
    
    var tlCardAnimator:TLCardAnimator!

    override func viewDidLoad() {
        super.viewDidLoad()
        
       initTabBarController()
       
    }
    
    func initTabBarController() -> Void {
        let vc1 = TabViewController1()
        let vc2 = TabViewController2()
        let vc3 = TabViewController3()
        let vc4 = TabViewController4()
        
    
        
        self.delegate = self
        self.setViewControllers([vc1,vc2,vc3,vc4], animated: true)
    }

    
    //MARK: - UITabBarController delegate
    func tabBarController(tabBarController: UITabBarController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    func tabBarController(tabBarController: UITabBarController, animationControllerForTransitionFromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
      
        if(tlCardAnimator == nil){
            tlCardAnimator = TLCardAnimator()
        }
        
        return tlCardAnimator
        
        
    }
}
