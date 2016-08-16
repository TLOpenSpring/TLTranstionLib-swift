//
//  TLHorizontalInteraction.swift
//  Pods
//
//  Created by Andrew on 16/8/8.
//
//

import UIKit

private let HorizontalTransitionCompletionPercentage:CGFloat = 0.3

public class TLHorizontalInteraction: TLBaseSwipeInteraction {

    override func isGesturePositive(panGestureRecognizer: UIPanGestureRecognizer) -> Bool {
        return self.translationWithPanGestureRecongizer(panGestureRecognizer: panGestureRecognizer) < 0
    }
    
    override func swipeCompletionPercent() -> CGFloat {
        return HorizontalTransitionCompletionPercentage
    }
    
    override func translationPercentageWithPanGestureRecongizer(panGestureRecognizer panGestureRecognizer: UIPanGestureRecognizer) -> CGFloat {
        
        return fabs(self.translationWithPanGestureRecongizer(panGestureRecognizer: panGestureRecognizer)/(panGestureRecognizer.view?.bounds.size.width)!)
    }
    
    /**
     手指实际滑动的距离
     
     - parameter panGestureRecognizer: 手势
     
     - returns: 返回手指移动的距离
     */
    override func translationWithPanGestureRecongizer(panGestureRecognizer panGestureRecognizer: UIPanGestureRecognizer) -> CGFloat {
        
        return panGestureRecognizer.translationInView(panGestureRecognizer.view).x
    }
    
    //MARK: - UIGestureRecognizerDelegate
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if  gestureRecognizer is UIPanGestureRecognizer{
            let panGesture = gestureRecognizer as! UIPanGestureRecognizer
            //在Y轴移动的距离
            let yTranslation = panGesture.translationInView(panGesture.view).y
            return yTranslation == 0
        }
        return true
    }
    
    
    
    
    
    
    
}
