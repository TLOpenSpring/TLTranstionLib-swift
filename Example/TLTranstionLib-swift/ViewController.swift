//
//  ViewController.swift
//  TLTranstionLib-swift
//
//  Created by Andrew on 05/09/2016.
//  Copyright (c) 2016 Andrew. All rights reserved.
//

import UIKit
import TLTranstionLib_swift



class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var arrayData:[String]!
    var tableView:UITableView?
    
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    
    
    
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
                   "Cube",
                   "Portal",
                   "Card",
                   "Fold",
                   "Turn",
                   "Geo"]
        self.initialData()
        initTable()
        
        let rightBarItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(tabbarAction(_:)))
        self.navigationItem.rightBarButtonItem = rightBarItem
        
    }
    
    func tabbarAction(sender:UIBarButtonItem) -> Void {
        let tab = TabBarControllerViewController()
        self.navigationController?.pushViewController(tab, animated: true)
    }
    
    func initialData() {
        screenWidth=UIScreen.mainScreen().bounds.width
        screenHeight=UIScreen.mainScreen().bounds.height
    }
    
    func initTable() {
        self.tableView=UITableView(frame: CGRectMake(0, 0, screenWidth, screenHeight-64));
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
        case "Divide":
            self.navigationController?.animatorStyle = .Divide
        case "FromLeft":
            self.navigationController?.animatorStyle = .FromLeft
        case "FlipOver":
            self.navigationController?.animatorStyle = .FlipOver
        case "FromTop":
            self.navigationController?.animatorStyle = .FromTop
        case "CoverVerticalFromTop":
            self.navigationController?.animatorStyle = .CoverVerticalFromTop
        case "Cube":
            self.navigationController?.animatorStyle = .Cube
        case "Portal":
            self.navigationController?.animatorStyle = .Portal
        case "Card":
            self.navigationController?.animatorStyle = .Card
            self.navigationController?.animatorDuration = 4
        case "Fold":
            self.navigationController?.animatorStyle = .Fold
        case "Turn":
            self.navigationController?.animatorStyle = .Turn
        case "Geo":
            self.navigationController?.animatorStyle = .Geo
        default:
            break
        }
        
        let vc1:TLController1 = TLController1()
     
        self.navigationController?.pushViewController(vc1, animated: true)

    }
  
    

}

