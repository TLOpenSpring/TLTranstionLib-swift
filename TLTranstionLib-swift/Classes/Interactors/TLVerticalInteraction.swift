//
//  TLVerticalInteraction.swift
//  Pods
//
//  Created by Andrew on 16/8/8.
//
//

import UIKit


private let VerticalTransitionCompletionPercentage:CGFloat = 0.3

public class TLVerticalInteraction: TLBaseSwipeInteraction {

    override func isGesturePositive(panGestureRecognizer: UIPanGestureRecognizer) -> Bool {
        return self.translationWithPanGestureRecongizer(panGestureRecognizer: panGestureRecognizer) < 0
    }
    
    override func swipeCompletionPercent() -> CGFloat {
        return VerticalTransitionCompletionPercentage
    }
    
    
    override func translationPercentageWithPanGestureRecongizer(panGestureRecognizer panGestureRecognizer: UIPanGestureRecognizer) -> CGFloat {
        return fabs(self.translationWithPanGestureRecongizer(panGestureRecognizer: panGestureRecognizer)/(panGestureRecognizer.view?.bounds.size.height)!)
    }
    
    
    override func translationWithPanGestureRecongizer(panGestureRecognizer panGestureRecognizer: UIPanGestureRecognizer) -> CGFloat {
        return panGestureRecognizer.translationInView(panGestureRecognizer.view).y
    }
    
    //MARK: - UIGestureRecognizerDelegate
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UIPanGestureRecognizer{
            let panGesture = gestureRecognizer as! UIPanGestureRecognizer
            let xTranslation = panGesture.translationInView(gestureRecognizer.view).x
            return xTranslation == 0
        }
        return true
    }
    
    
    
}
