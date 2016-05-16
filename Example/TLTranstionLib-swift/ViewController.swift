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
        arrayData=["System","Fade"]
        self.initialData()
        initTable()
        
    }
    
    func initialData() {
        screenWidth=UIScreen.mainScreen().bounds.width
        screenHeight=UIScreen.mainScreen().bounds.height
    }
    
    func initTable() {
        self.tableView=UITableView(frame: CGRectMake(0, 64, screenWidth, screenHeight-64));
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
        
        cell?.textLabel?.text=arrayData[indexPath.row]
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let style=arrayData[indexPath.row] as String;
        
        if(style == "System"){
            self.navigationController?.animatorDuration = 1;
            self.navigationController!.animatorStyle = .System
        }else if(style == "Fade"){
            self.navigationController!.animatorStyle = .Fade
            self.navigationController?.animatorDuration = 1;
        }
        
        let vc1:TLController1 = TLController1()
     
        self.navigationController?.pushViewController(vc1, animated: true)

    }
  
    

}

