# TLTranstionLib-swift
<<<<<<< HEAD

[![CI Status](http://img.shields.io/travis/Andrew/TLTranstionLib-swift.svg?style=flat)](https://travis-ci.org/Andrew/TLTranstionLib-swift)
[![Version](https://img.shields.io/cocoapods/v/TLTranstionLib-swift.svg?style=flat)](http://cocoapods.org/pods/TLTranstionLib-swift)
[![License](https://img.shields.io/cocoapods/l/TLTranstionLib-swift.svg?style=flat)](http://cocoapods.org/pods/TLTranstionLib-swift)
[![Platform](https://img.shields.io/cocoapods/p/TLTranstionLib-swift.svg?style=flat)](http://cocoapods.org/pods/TLTranstionLib-swift)

##效果图

###System
![system](http://7xsn4e.com2.z0.glb.clouddn.com/System.gif)

###Fade
![fade](http://7xsn4e.com2.z0.glb.clouddn.com/Fade.gif)

###FromLeft
![fromLeft](http://7xsn4e.com2.z0.glb.clouddn.com/Fromleft.gif)

###FlibOver
![flibover](http://7xsn4e.com2.z0.glb.clouddn.com/Flipover.gif)

###CoverFromTop
![coverFromTop](http://7xsn4e.com2.z0.glb.clouddn.com/CoverFromTop.gif)

###Devide
![devide](http://7xsn4e.com2.z0.glb.clouddn.com/devide.gif)

###FromTop
![fromTop](http://7xsn4e.com2.z0.glb.clouddn.com/FromTop.gif)

###CoverFrombottom
![bottom](http://7xsn4e.com2.z0.glb.clouddn.com/CoverFromBottom.gif)

###Cube
![cube](http://7xsn4e.com2.z0.glb.clouddn.com/cube.gif)

###Explode
![explode](http://7xsn4e.com1.z0.glb.clouddn.com/Explode.gif)

###Card
![Card](http://7xsn4e.com1.z0.glb.clouddn.com/Card.gif)

### trun
![trun](http://7xsn4e.com1.z0.glb.clouddn.com/turn.gif)

### Flip
![flip](http://7xsn4e.com1.z0.glb.clouddn.com/Flip.gif)

### Geo
![geo](http://7xsn4e.com1.z0.glb.clouddn.com/Geo.gif)

### Portal
![Portal](http://7xsn4e.com1.z0.glb.clouddn.com/Portal.gif)

### Fold
![Fold](http://7xsn4e.com1.z0.glb.clouddn.com/Fold.gif)



## Requirements

## Installation

TLTranstionLib-swift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "TLTranstionLib-swift"
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

转场动画是建立在ios系统的容器视图上，分别为

* UINavigationController的push和pop
* UIViewController的Present和Dismiss的方法()

类库同样也支持在UItabBarController之间切换时添加动画效果


### 在UINavigationContrller中调用

1. 首先要调用 TLTransitionNavigationController（类库中封装）,其实就是设置 UINavigationController.delegate的代理 = TLTransitionManager.shared()
2. 设置动画有两个API
	
	1. *第一种*
	
	```
	    /**
     设置动画的效果，当一个UIViewController到另一个UIViewController时
     
     - parameter animation:          动画实现类
     - parameter fromViewController: 开始过渡的动画类
     - parameter action:             操作类型，比如推送(push),pop(弹回),present(跳转),dismiss(消失)
     */
   public func tl_setAnimation(animation animation:TLAnimationProtocol,fromViewController:AnyClass,action:TLTranstionAction) -> Void
	```
	*比如这样调用:*
	
	```
		TLTransitionManager.shared().tl_setAnimation(animation: TLDivideAnimator(), fromViewController: self.dynamicType, action: .tl_PushPop)
	```
	
	2. *第二种*

	```
	 /**
     设置动画的效果，当一个UIViewController到另一个UIViewController时,
     
     - parameter animation:          动画实现类
     - parameter fromViewController: 开始过渡的动画类
     - parameter toViewController:   The @c UIViewController class that is being transitioned to.
     - parameter action:             操作类型，比如推送(push),pop(弹回),present(跳转),dismiss(消失)
     */
    public func tl_setAnimation(animation animation:TLAnimationProtocol,fromViewController:AnyClass?,toViewController:AnyClass?,action:TLTranstionAction) -> Void 
	```
	
	调用如下:
	
	```
	TLTransitionManager.shared().tl_setAnimation(animation: TLDivideAnimator(), fromViewController: self.dynamicType, toViewController: TLController1.self, action: .tl_PushPop)
	```
	

3. 使用系统的UINavigatonController进行push 和 pop

```
let vc1:TLController1 = TLController1()
        //必须设置代理,不然没有效果
        vc1.transitioningDelegate = TLTransitionManager.shared()
        self.navigationController?.pushViewController(vc1, animated: true)
```

api的最后一个参数是acion,这个acton有好几种类型，如果是设置 `. tl_PushPop`,则说明从页面A跳转到页面B,会有push的动画，从B页面Pop到A页面时，也会有转场动画；

如果仅仅是设置 `tl_Push` 或者 `tl_Pop`,那么只会有一个单项的转场动画。

> *注意*
> 
> 第二个API的优先级高于第一个，所以如果已经设置了第二个APi的转场动画，再设置第一个API，则不起作用，反之，则是可以工作的。
> 
> 
> 


### UIViewController的Present

假如有两个页面,A和B；
从页面A 跳转到页面B，那么要在B的页面设置动画效果，

*第一种API调用*

```
TLTransitionManager.shared().tl_setAnimation(animation: TLFadeAnimator(), fromViewController: self.dynamicType, action: .tl_PresentDismiss)

self.presentViewController(vc1, animated: true, completion: nil)
```


*第二种API调用*

```
TLTransitionManager.shared().tl_setAnimation(animation: TLFadeAnimator(), fromViewController:ViewController.self , toViewController:TLController1.self , action: .tl_PresentDismiss)

self.presentViewController(vc1, animated: true, completion: nil)
```

api的最后一个参数是acion,这个acton有好几种类型，如果是设置 `. tl_PresentDismiss`,则说明从页面A跳转到页面B,会有present的动画，从B页面dismiss到A页面时，也会有转场动画；

如果仅仅是设置 `tl_Present` 或者 `tl_Dismiss`,那么只会有一个单项的转场动画。



## Author

Andrew, andrewswift1987@gmail.com

## License

TLTranstionLib-swift is available under the MIT license. See the LICENSE file for more info.
=======
史上最全的ViewController之间切换动画的类库，API简单易用
>>>>>>> 80c2eb69de0f0cb8764644b1bdf3895baddc42a6
