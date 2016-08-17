//
//  ViewController.swift
//  TLTranstionLib-swift
//
//  Created by Andrew on 05/09/2016.
//  Copyright (c) 2016 Andrew. All rights reserved.
//

import UIKit
import TLTranstionLib_swift



class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,TLTransitionInteractionControllerDelegate {

    var arrayData:[String]!
    var tableView:UITableView?
    
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    var pushPopInteractionController: TLTransitionInteractionProtocol?
    var presentInteractionController: TLTransitionInteractionProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.whiteColor()
        self.title="首页";
        arrayData=["System",
                   "Fade",
                   "Divide",
                   "FromLeft",
                   "FlipOver",
                   "FromTop",
                   "CoverVerticalFromTop",
                   "Cubehorizontal",
                   "CubeVertical",
                   "Portal",
                   "Card",
                   "Fold",
                   "Turn",
                   "Geo",
        "Explode"]
        self.initialData()
        initTable()
        
        let rightBarItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(tabbarAction(_:)))
        self.navigationItem.rightBarButtonItem = rightBarItem
        
        
        initInteraction()
        
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
    
    func tabbarAction(sender:UIBarButtonItem) -> Void {
        let tab = TabBarControllerViewController()
        
        let nav = UINavigationController(rootViewController: tab)
        
//        self.navigationController?.pushViewController(tab, animated: true)
        self.presentViewController(nav, animated: true, completion: nil)
    }
    
    func initialData() {
        screenWidth=UIScreen.mainScreen().bounds.width
        screenHeight=UIScreen.mainScreen().bounds.height
    }
    
    func initTable() {
        self.tableView=UITableView(frame: CGRectMake(0, 0, screenWidth, screenHeight));
            self.tableView?.dataSource=self;
            self.tableView?.delegate=self;
        self.view.addSubview(self.tableView!);
    }

    //MARK: - UITableview delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell")
        if(cell == nil){
          cell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        }
        
        cell?.accessoryType = .DisclosureIndicator
        cell?.textLabel?.text=arrayData[indexPath.row]
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let style = arrayData[indexPath.row];
        
        switch style {
        case "System":
            self.navigationController?.animatorStyle = .System
        case "Fade":
            self.navigationController?.animatorStyle = .Fade
            
            TLTransitionManager.shared().tl_setAnimation(animation: TLFadeAnimator(), fromViewController: self.dynamicType, action: .tl_PushPop)
            
        case "Divide":
            self.navigationController?.animatorStyle = .Divide
            
            TLTransitionManager.shared().tl_setAnimation(animation: TLDivideAnimator(), fromViewController: ViewController.self, action: .tl_PushPop)
            
            
        case "FromLeft":
            self.navigationController?.animatorStyle = .FromLeft
            TLTransitionManager.shared().tl_setAnimation(animation:TLFromLeftAnimator() , fromViewController: self.dynamicType, action: .tl_PushPop)
        case "FlipOver":
            self.navigationController?.animatorStyle = .FlipOver
            TLTransitionManager.shared().tl_setAnimation(animation:TLFlipOverAnimator() , fromViewController: self.dynamicType, action: .tl_PushPop)
        case "FromTop":
            self.navigationController?.animatorStyle = .FromTop
            TLTransitionManager.shared().tl_setAnimation(animation:TLFromTopAnimator() , fromViewController: self.dynamicType, action: .tl_PushPop)
        case "CoverVerticalFromTop":
            self.navigationController?.animatorStyle = .CoverVerticalFromTop
            self.navigationController?.animatorDuration = 1
            TLTransitionManager.shared().tl_setAnimation(animation:TLCoverVerticalAnimator() , fromViewController: self.dynamicType, action: .tl_PushPop)
        case "Cubehorizontal":
            self.navigationController?.animatorStyle = .Cube
            self.navigationController?.animatorDuration = 1
            
            TLTransitionManager.shared().tl_setAnimation(animation:TLCubeAnimator() , fromViewController: self.dynamicType, action: .tl_PushPop)
        case "CubeVertical":
            self.navigationController?.animatorDuration = 1
            self.navigationController?.animatorStyle = .Cube
            
            let cube = TLCubeAnimator()
            cube.cubeDirecation = .vertical
            
            TLTransitionManager.shared().tl_setAnimation(animation: cube, fromViewController: self.dynamicType, action: .tl_PushPop)
        case "Portal":
            self.navigationController?.animatorStyle = .Portal
        case "Card":
            self.navigationController?.animatorStyle = .Card
            TLTransitionManager.shared().tl_setAnimation(animation: TLCardAnimator(), fromViewController: self.dynamicType, action: .tl_PushPop)
        case "Fold":
            self.navigationController?.animatorStyle = .Fold
            TLTransitionManager.shared().tl_setAnimation(animation: TLFoldAnimator(), fromViewController: self.dynamicType, action: .tl_PushPop)
        case "Turn":
            self.navigationController?.animatorStyle = .Turn
        case "Geo":
            self.navigationController?.animatorStyle = .Geo
        case "Explode":
            self.navigationController?.animatorStyle = .Explode
            self.navigationController?.animatorDuration = 1
            TLTransitionManager.shared().tl_setAnimation(animation: TLExplodeAnimator(), fromViewController: self.dynamicType, action: .tl_PushPop)
        default:
            break
        }
        
        
        
        let vc1:TLController1 = TLController1()
     
        self.navigationController?.pushViewController(vc1, animated: true)

    }
  
    
    //MARK: - TLTransitionInteractionControllerDelegate
    func nextViewControllerForInteractor(interactor: TLTransitionInteractionProtocol) -> UIViewController {
        
        let simple = SimpleViewController()
        return simple
    }
    

}

