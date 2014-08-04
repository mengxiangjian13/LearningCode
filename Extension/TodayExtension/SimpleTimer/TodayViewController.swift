//
//  TodayViewController.swift
//  SimpleTimer
//
//  Created by Xiangjian Meng on 14-8-4.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController {
    
    
    @IBOutlet weak var todayLabel: UILabel!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        let userDefault = NSUserDefaults(suiteName: "group.develop")
        
        let leftTime = userDefault.integerForKey("LeftTime")
        let passTime = Int(NSDate().timeIntervalSince1970) - userDefault.integerForKey("ThisTime")
        let showTime = leftTime - passTime
        todayLabel.text = "\(showTime)"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encoutered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
