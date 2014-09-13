//
//  SecondViewController.swift
//  PresentController
//
//  Created by Xiangjian Meng on 14-9-13.
//  Copyright (c) 2014年 Xiangjian Meng. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var button : UIButton! = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.layer.cornerRadius = 20.0
        view.layer.shadowColor = UIColor.blackColor().CGColor
        view.layer.shadowOffset = CGSizeMake(0, 0)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.5
        
        self.view.backgroundColor = UIColor.yellowColor();
        
        button = UIButton.buttonWithType(.System) as UIButton;
        button.setTitle("dismiss", forState: .Normal);
        button.frame = CGRectMake(0, 0, 100, 50);
        button.center = self.view.center;
        button.addTarget(self, action: "close", forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(button);
    }
    
    func rotateDidFinish()
    {
        button.center = self.view.center;
    }
    
    func close()
    {
        self.transitioningDelegate = nil;
        self.dismissViewControllerAnimated(true, completion: {});
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
