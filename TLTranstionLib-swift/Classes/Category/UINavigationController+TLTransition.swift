//
//  UINavigationController+TLTransition.swift
//  Pods
//
//  Created by Andrew on 16/5/14.
//
//

import UIKit

/**
private var proxyKey:Void




public extension UINavigationController {
    public var animatorStyle:TLAnmimatorStyle{
        
        get{
          return  self.proxy.animatorStyle!
        }
        set(newValue){
            self.proxy.setAnimatorStyle(newValue)
        }
    }
    
    public var animatorDuration:NSTimeInterval?{
        get{
            if(animatorDuration == 0){
              animatorDuration = 0.3
            }
          return animatorDuration
        }
        set(newValue){
          self.proxy.tlDuration=newValue
        }
    }
    
    public var proxy:TLTransitionProxy{
        get{
            var myProxy:TLTransitionProxy? = objc_getAssociatedObject(self, &proxyKey) as? TLTransitionProxy
            if(myProxy == nil){
                myProxy = TLTransitionProxy.alloc()
                myProxy?.initial()
                self.proxy = myProxy!;
            }
            return myProxy!
        }
        set(newValue){
         objc_setAssociatedObject(self, &proxyKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
       // self.delegate = self.proxy.delegate
    }
    
  
    
//    public override class func initialize(){
//        print("执行了initialize")
//        var onceToken:dispatch_once_t = 0
//        dispatch_once(&onceToken) {
//            
//            var cl:AnyClass = self.classForCoder()
//            let originalSelectors = ["viewDidLoad","setDelegate","delegate"]
//            let swizzledSelectors = ["tl_viewDidLoad","tl_setDelegate","tl_delegate"]
//            
//            for (var i = 0;i < originalSelectors.count;i++){
//                let originalSeletor = NSSelectorFromString(originalSelectors[i])
//                let swizzledSelector = NSSelectorFromString(swizzledSelectors[i])
//                
//                let originalMethod = class_getInstanceMethod(cl, originalSeletor)
//                let swizzledMethod = class_getInstanceMethod(cl, swizzledSelector)
//                
//                /// 动态的增加方法
//                /**
//                 @param cl 向指定的类型添加方法
//                 @param  originalMethod 可以理解为方法名，这个貌似随便起名，比如我们这里叫‘sayHello2’
//                 @param swizzledMethod 实现类
//                 @param method_getTypeEncoding(originalMethod) 一个定义该函数返回值类型和参数类型的字符串
//                 */
//                
//                let result = class_addMethod(cl, originalSeletor, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
//                
//                if(result){
//                    /**
//                     *  动态替换类中指定的方法
//                     *
//                     *  @param cl               指定的类
//                     *  @param swizzledSelector 目标要替换的方法
//                     *  @param originalMethod   用这个实现的方法去替换
//                     *
//                     *  @return
//                     */
//                    class_replaceMethod(cl, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
//                }else{
//                    method_exchangeImplementations(originalMethod, swizzledMethod)
//                }
//            }
//        }
//
//    }
    
    
    
    
  
    
    
    /**
     ViewDidload方法
     */
    func tl_viewDidLoad() {
        self.tl_viewDidLoad()
         self.delegate = self.proxy.delegate
        //self.interactivePopGestureRecognizer?.delegate=self;
        //self.delegate = self.delegate!
    }
//    
//    func tl_setDelegate(delegate:UINavigationControllerDelegate)  {
//        self.proxy.delegate = delegate
//        self.tl_setDelegate(self.proxy)
//    }
//    
//    func tl_delegate() -> UINavigationControllerDelegate? {
//        return self.proxy.delegate
//    }
    
    
}

*/












