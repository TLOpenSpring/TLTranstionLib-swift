//
//  TabViewController2.swift
//  TLTranstionLib-swift
//
//  Created by Andrew on 16/7/22.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import TLTranstionLib_swift

class TabViewController2: BaseTabController,UITableViewDelegate,UITableViewDataSource{
    
    var arrayData:[String]!
    var tableView:UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "TabViewController2"
        self.view.backgroundColor = UIColor.brownColor()
        
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
        
        
        self.navigationController?.delegate = TLTransitionManager.shared()
        initTable()
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
            break
        case "Fade":
            TLTransitionManager.shared().tl_setAnimation(animation: TLFadeAnimator(), fromViewController: self.dynamicType, action: .tl_PushPop)
            break
        case "Divide":

            TLTransitionManager.shared().tl_setAnimation(animation: TLDivideAnimator(), fromViewController: self.dynamicType, action: .tl_PushPop)
            
            
        case "FromLeft":
            TLTransitionManager.shared().tl_setAnimation(animation:TLFromLeftAnimator() , fromViewController: self.dynamicType, action: .tl_PresentDismiss)
        case "FlipOver":
            TLTransitionManager.shared().tl_setAnimation(animation:TLFlipOverAnimator() , fromViewController: self.dynamicType, action: .tl_PushPop)
        case "FromTop":
            TLTransitionManager.shared().tl_setAnimation(animation:TLFromTopAnimator() , fromViewController: self.dynamicType, action: .tl_PushPop)
        case "CoverVerticalFromTop":
            TLTransitionManager.shared().tl_setAnimation(animation:TLCoverVerticalAnimator() , fromViewController: self.dynamicType, action: .tl_PushPop)
            
        case "Cubehorizontal":
            TLTransitionManager.shared().tl_setAnimation(animation:TLCubeAnimator() , fromViewController: self.dynamicType, action: .tl_PushPop)
        case "CubeVertical":
            
            let cube = TLCubeAnimator()
            cube.cubeDirecation = .vertical
            
            TLTransitionManager.shared().tl_setAnimation(animation: cube, fromViewController: self.dynamicType, action: .tl_PushPop)
        case "Portal":
            break
        case "Card":
            TLTransitionManager.shared().tl_setAnimation(animation: TLCardAnimator(), fromViewController: self.dynamicType, action: .tl_PushPop)
        case "Fold":
            TLTransitionManager.shared().tl_setAnimation(animation: TLFoldAnimator(), fromViewController: self.dynamicType, action: .tl_PushPop)
        case "Turn":
            break
        case "Geo":
            break
        case "Explode":
            TLTransitionManager.shared().tl_setAnimation(animation: TLExplodeAnimator(), fromViewController: self.dynamicType, action: .tl_PushPop)
        default:
            break
        }
        
        let vc1:TLController1 = TLController1()
        //必须设置代理,不然没有效果
        vc1.transitioningDelegate = TLTransitionManager.shared()
        self.navigationController?.pushViewController(vc1, animated: true)

        
    }
    

}




