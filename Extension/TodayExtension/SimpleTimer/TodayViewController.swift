//
//  TodayViewController.swift
//  SimpleTimer
//
//  Created by Xiangjian Meng on 14-8-4.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit
import NotificationCenter
import SimpleTimerKit

class TodayViewController: UIViewController, TimerDelegate{
    
    
    @IBOutlet weak var todayLabel: UILabel!
    
    var timer : Timer?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        self.preferredContentSize = CGSizeMake(0, 100)
        
        let userDefault = NSUserDefaults(suiteName: "group.develop")
        
        let leftTime = userDefault.integerForKey("LeftTime")
        let passTime = Int(NSDate().timeIntervalSince1970) - userDefault.integerForKey("ThisTime")
        let showTime = leftTime - passTime
        todayLabel.text = "\(showTime)"
        
        if timer == nil
        {
            if showTime > 0
            {
                timer = Timer(delegate: self)
                timer!.start(showTime)
            }
            else
            {
                self.addButton()
            }
            
        }
        
    }
    
    func timerDidStop()
    {
        if todayLabel
        {
            todayLabel.text = "\(timer!.leftTime)"
        }
        
        if timer?.leftTime == 0
        {
            todayLabel.hidden = true
            self.addButton()
        }
    }
    
    func addButton()
    {
        let backAppButton: AnyObject! = UIButton.buttonWithType(UIButtonType.System)
        if let button = backAppButton as? UIButton
        {
            button.frame = CGRectMake(0, 50, 50, 63)
            button.setTitle("Open", forState: UIControlState.Normal)
            button.addTarget(self, action: "backToApp", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(button)
        }
    }
    
    func backToApp()
    {
        // URL Scheme 的方式返回containing app
        self.extensionContext.openURL(NSURL(string: "TodayExtension://finished"), completionHandler: nil)
    }
    
    func timerDidUpdate(remainTime:NSInteger)
    {
        if todayLabel
        {
            todayLabel.text = "\(remainTime)"
        }
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
