//
//  TLTransitionProxy.swift
//  Pods
//
//  Created by Andrew on 16/5/13.
//
//

import UIKit

public class TLTransitionProxy:NSProxy,UINavigationControllerDelegate {

  
    public var delegate:UINavigationControllerDelegate?
        /// 动画的种类
    public var animatorStyle:TLAnmimatorStyle?
        /// 动画的基类
    public var baseAnimator:TLBaseAnimator?
    
    private var tlFadeAnimator:TLFadeAnimator!
    private var tlFromleftAnimator:TLFromLeftAnimator!
    private var tlCardAnimator:TLCardAnimator!
    private var tlCoverVerticalAnimator:TLCoverVerticalAnimator!
    private var tlCubeAnimator:TLCubeAnimator!
    private var tlDivideAnimator:TLDivideAnimator!
    private var tlExplodeAnimator:TLExplodeAnimator!
    private var tlFlipAnimator:TLFlipAnimator!
    private var tlFlipOverAnimator:TLFlipOverAnimator!
    private var tlFoldAnimator:TLFoldAnimator!
    private var tlFromTopAnimator:TLFromTopAnimator!
    private var tlGeoAnimator:TLGeoAnimator!
    private var tlTurnAnimator:TLTurnAnimator!
    private var tlPortalAnimator:TLPortalAnimator!
    private var tlVerticalFromBottonAnimator:TLVerticalFromBottonAnimator!
    
  
        /// 动画执行的时间
    public var tlDuration:NSTimeInterval?
    
 
    
    public func initial() {
        self.delegate = self;
    }
    
    
    func TL_animatorStyle(style:TLAnmimatorStyle) -> TLBaseAnimator {
        var animator:TLBaseAnimator = TLBaseAnimator()
        switch style {
        case .System:
            break;
        case .FromLeft:
            animator = self.crateFromleftAnimator()
            break
        case .Fade:
            animator = self.createFadeAnimator()
            break;
        case .Card:
            animator = self.createCardAnimator()
        case .Cube:
            animator = self.createCubeAnimator()
        case .Divide:
            animator = self.createDivideAnimator()
        case .FlipOver:
            animator = self.createFlibOverAnimator()
        case .FromTop:
            animator = self.createFromTopAnimator()
        case .Geo:
            animator = self.createGeoAnimator()
        case .Portal:
            animator = self.createPortalAnimator()
        case .Turn:
            animator = self.createTurnAnimator()
        case .CoverVerticalFromTop:
            animator = self.createCoverVerticalAnimator()
        case .VerticalFromBottom:
            tlVerticalFromBottonAnimator = self.createVerticalFromBottonAnimater()
        default:
            break;
        }
        return animator;
    }
    
   public  func setAnimatorStyle(animatorStyle:TLAnmimatorStyle) -> Void {
        self.animatorStyle = animatorStyle;
        self.baseAnimator = TL_animatorStyle(animatorStyle);
    }
   
    //MARK: - 创建动画的工厂方法
    func crateFromleftAnimator() -> TLFromLeftAnimator {
        if(tlFromleftAnimator == nil){
         tlFromleftAnimator = TLFromLeftAnimator()
        }
        
        return tlFromleftAnimator!
    }
    
    func createFadeAnimator() -> TLFadeAnimator {
        if(tlFadeAnimator == nil){
            tlFadeAnimator = TLFadeAnimator();
        }
        return tlFadeAnimator!
    }
    
    func createCardAnimator() -> TLCardAnimator {
        if(tlCardAnimator == nil){
          tlCardAnimator = TLCardAnimator()
        }
        
        return tlCardAnimator
    }
    
    func createCoverVerticalAnimator() -> TLCoverVerticalAnimator {
        if(tlCoverVerticalAnimator == nil){
          tlCoverVerticalAnimator = TLCoverVerticalAnimator()
        }
        return tlCoverVerticalAnimator
    }
    
    func createCubeAnimator() -> TLCubeAnimator {
        if(tlCubeAnimator == nil) {
         tlCubeAnimator = TLCubeAnimator()
        }
        return tlCubeAnimator
    }
    
    func createDivideAnimator() -> TLDivideAnimator {
        if(tlDivideAnimator == nil){
         tlDivideAnimator = TLDivideAnimator()
        }
        return tlDivideAnimator
    }
    func createExplodeAnimator() -> TLExplodeAnimator {
        if(tlExplodeAnimator == nil){
         tlExplodeAnimator = TLExplodeAnimator()
        }
        return tlExplodeAnimator
    }
    
    func createFlibOverAnimator() -> TLFlipOverAnimator {
        if(tlFlipOverAnimator == nil){
          tlFlipOverAnimator = TLFlipOverAnimator()
        }
        
        return tlFlipOverAnimator
    }
    
    func createFoldAnimator() -> TLFoldAnimator {
        if(tlFoldAnimator == nil){
          tlFoldAnimator = TLFoldAnimator()
        }
        
        return tlFoldAnimator
    }
    
    func createFromTopAnimator() -> TLFromTopAnimator {
        if(tlFromTopAnimator == nil){
         tlFromTopAnimator = TLFromTopAnimator()
        }
        
        return tlFromTopAnimator
    }
    
    func createGeoAnimator() -> TLGeoAnimator {
        if(tlGeoAnimator == nil){
         tlGeoAnimator = TLGeoAnimator()
        }
        
        return tlGeoAnimator
    }

    func createPortalAnimator() -> TLPortalAnimator {
        if(tlPortalAnimator == nil){
         tlPortalAnimator = TLPortalAnimator()
        }
        
        return tlPortalAnimator
    }
    
    func createTurnAnimator() -> TLTurnAnimator {
        if(tlTurnAnimator == nil){
         tlTurnAnimator = TLTurnAnimator()
        }
        
        return tlTurnAnimator
    }
    
    func createVerticalFromBottonAnimater() -> TLVerticalFromBottonAnimator {
        if(tlVerticalFromBottonAnimator == nil){
         tlVerticalFromBottonAnimator = TLVerticalFromBottonAnimator()
        }
        
        return tlVerticalFromBottonAnimator;
    }
 
    
    //MARK: - NSProxy代理
    /**
     支持响应的代理方法
     
     - parameter aSelector: 方法
     
     - returns: 是否相应该方法
     */
    public override func respondsToSelector(aSelector: Selector) -> Bool {
       
        if(aSelector == #selector(self.delegate?.navigationController(_:animationControllerForOperation:fromViewController:toViewController:))){
            return true;
        }
        
        return false;
       
    }
    
    
    //MARK:- UINavigationControllerDelegate
    public func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        var animatorTransition:UIViewControllerAnimatedTransitioning?
        
        
        switch operation {
        case .None:
            animatorTransition=nil
            return animatorTransition;
        default:
            let style:TLAnmimatorStyle = navigationController.animatorStyle;
            if(style != TLAnmimatorStyle.None){
                let animator:TLBaseAnimator = self.TL_animatorStyle(style);
                animator.operaiton = operation;
                animator.animatorDuration = self.tlDuration!
                animatorTransition=animator;
            }else{
                self.baseAnimator?.operaiton=operation;
                animatorTransition = self.baseAnimator;
            }
            break;
        }
        
        return animatorTransition;
        
    }
    
    public func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return nil
    }
    
}
