//
//  ViewController.swift
//  VFLDemo
//
//  Created by mengxiangjian on 15/11/10.
//  Copyright © 2015年 mengxiangjian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let redView = UIView()
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.backgroundColor = UIColor.redColor()
        view.addSubview(redView)
        
        let dict = ["redView" : redView]
        
        let vfl1 = "|-50-[redView(100)]"
        let vfl2 = "V:|-100-[redView(100)]"
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(vfl1, options: NSLayoutFormatOptions(), metrics: nil, views: dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(vfl2, options: NSLayoutFormatOptions(), metrics: nil, views: dict))
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

