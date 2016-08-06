//
//  TLUniqueTransitionModel.swift
//  Pods
//
//  Created by Andrew on 16/8/6.
//
//

import UIKit

class TLUniqueTransitionModel: NSObject,NSCopying {

    /// 页面跳转方式 push/pop/present/dimiss ...
    var transitionAction:TLTranstionAction!
    
    /// 开始的ViewController
    var fromViewController:AnyClass?
    /// 目的的ViewController
    var toViewController:AnyClass?
    
    
    init(action:TLTranstionAction,fromController:AnyClass,toController:AnyClass?) {
        self.transitionAction = action
        self.fromViewController = fromController
        self.toViewController = toController
    }
    
    
    //MARK: - NSCopying Protocol
    func copyWithZone(zone: NSZone) -> AnyObject {
        
        let copied = self.copy() as! TLUniqueTransitionModel
        copied.transitionAction = self.transitionAction
        copied.fromViewController = self.fromViewController
        copied.toViewController = self.toViewController
        
        return copied
    }
    
//    override var hash: Int{
//        return (self.fromViewController?.hash())! ^ (self.toViewController?.hash())! ^ self.transitionAction
//    }
    
   
    
   

    override func isEqual(object: AnyObject?) -> Bool {
        if (object is TLUniqueTransitionModel) == false{
         return false
        }
        let otherObj = object as! TLUniqueTransitionModel
        
        let result = (otherObj.transitionAction == self.transitionAction) && (otherObj.fromViewController == self.fromViewController) && (otherObj.toViewController == self.toViewController)
        
        return result
    }
    
    
}
