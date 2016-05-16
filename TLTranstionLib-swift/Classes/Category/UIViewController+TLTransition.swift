//
//  UIViewController+TLTransition.swift
//  Pods
//
//  Created by Andrew on 16/5/13.
//
//

import UIKit


public enum TLAnmimatorStyle:Int32 {
    case System = 1
    case Fade = 2
    case Divide = 3
    case FromLeft = 4
    case FlipOver = 5
    case FromTop = 6
    case CoverVerticalFromTop = 7
    case VerticalFromBottom = 8
    case Cube = 9
    case Portal = 10
    case Card = 11
    case Fold = 12
    case Turn = 13
    case Geo = 14
    case None = 15
}


private var TransitionStyleKey:Void?

public extension UIViewController{
    
   public var tlTranstionAnimatorStyle:TLAnmimatorStyle{
        
        get{
            var style:TLAnmimatorStyle? = objc_getAssociatedObject(self, &TransitionStyleKey) as? TLAnmimatorStyle;
            
            if style == nil
            {
                style = .System;
            }else{
                self.tlTranstionAnimatorStyle = style!;
            }
            
            return style!;
       }
        
    set(newValue){
        objc_setAssociatedObject(self, &TransitionStyleKey,NSNumber(int: newValue.rawValue) , .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    }
  
  
}
