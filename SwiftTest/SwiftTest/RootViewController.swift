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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tap(){
        println("tap tap tap")
        let tableView = TableViewController(nibName: nil, bundle: nil)
        self.presentViewController(tableView, animated: true, completion: nil)
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
