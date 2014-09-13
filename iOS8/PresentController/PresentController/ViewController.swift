//
//  ViewController.swift
//  PresentController
//
//  Created by Xiangjian Meng on 14-9-13.
//  Copyright (c) 2014年 Xiangjian Meng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.redColor();
        
        let button = UIButton.buttonWithType(.System) as UIButton;
        button.setTitle("present", forState: .Normal);
        button.frame = CGRectMake(0, 0, 100, 50);
        button.center = self.view.center;
        button.addTarget(self, action: "present", forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(button);
        
        
    }
    
    func present()
    {
        let sVC = SecondViewController();
        let td = OverTransitioningDelegate();
        sVC.transitioningDelegate = td;
        sVC.modalPresentationStyle = .Custom;
        self.presentViewController(sVC, animated: true, completion: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

