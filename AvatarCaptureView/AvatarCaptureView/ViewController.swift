//
//  ViewController.swift
//  AvatarCaptureView
//
//  Created by Xiangjian Meng on 14/10/23.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var captureView : CaptureView! = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        captureView = CaptureView(frame:self.view.bounds);
        captureView.backgroundColor = UIColor.whiteColor();
        self.view.addSubview(captureView);
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

