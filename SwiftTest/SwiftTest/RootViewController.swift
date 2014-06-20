//
//  RootViewController.swift
//  SwiftTest
//
//  Created by Xiangjian Meng on 14-6-18.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    var naviVC : UINavigationController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let button = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        button!.frame = CGRectMake(100,100,100,100)
        button!.backgroundColor = UIColor.redColor()
        self.view.addSubview(button)
        button!.setTitle("hao",forState:UIControlState.Normal)
        button!.setTitleColor(UIColor.blackColor(),forState:UIControlState.Normal)
        button!.addTarget(self, action: "tap", forControlEvents: UIControlEvents.TouchUpInside)
        
        var label : UILabel = UILabel(frame:CGRectMake(0,0,200,50))
        label.font = UIFont.systemFontOfSize(15)
        label.text = "hellow,world!"
        label.textAlignment = .Center
        label.textColor = UIColor.blackColor()
        label.center = self.view.center
        self.view.addSubview(label)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tap(){
        println("tap tap tap")
        let tableView = TableViewController(nibName: nil, bundle: nil)
        naviVC = UINavigationController(rootViewController:tableView)
        let closeItem = UIBarButtonItem(barButtonSystemItem:.Cancel,target:self,action:"close")
        tableView.navigationItem.leftBarButtonItem = closeItem;
        self.presentViewController(naviVC, animated: true, completion: nil)
    }
    
    func close(){
       naviVC!.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
