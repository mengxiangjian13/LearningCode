//
//  ViewController.swift
//  EffectView
//
//  Created by Xiangjian Meng on 14-8-12.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.blackColor()
        
        let button: AnyObject! = UIButton.buttonWithType(UIButtonType.System)
        if let b = button as? UIButton
        {
            b.frame = CGRectMake(0, 0, 100, 100)
            b.setTitle("弹出毛玻璃", forState: .Normal)
            b.center = CGPointMake(160, 450)
            b.addTarget(self, action: "presentEffectView", forControlEvents: UIControlEvents.TouchUpInside)
            view.addSubview(b)
        }
        
    }
    
    func presentEffectView()
    {
        println("弹出毛玻璃")
        
        let effectVC = EffectViewController()
        // 设置弹出style为overFullScreen，这样可以看到背后的东西
        effectVC.modalPresentationStyle = .OverFullScreen
        self.presentViewController(effectVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

