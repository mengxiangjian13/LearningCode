//
//  ViewController.swift
//  TodayExtension
//
//  Created by Xiangjian Meng on 14-8-4.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit
import SimpleTimerKit

class ViewController: UIViewController, TimerDelegate {
    
    var label:UILabel?
    var timer:Timer?
    let totalTime = 3600
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "willResignActive", name: UIApplicationWillResignActiveNotification, object: nil)
        
        timer = Timer(delegate: self)
        
        label = UILabel(frame: CGRectMake(0, 0, 100, 100))
        label!.center = self.view.center
        label!.font = UIFont.systemFontOfSize(30)
        label!.textColor = UIColor.blackColor()
        label!.textAlignment = NSTextAlignment.Center
        self.view.addSubview(label)
        label!.text = "\(totalTime)"
        
        
        let startButton: AnyObject! = UIButton.buttonWithType(UIButtonType.System)
        if let button = startButton as? UIButton
        {
            button.setTitle("start", forState: UIControlState.Normal)
            button.frame = CGRectMake(0, 0, 50, 50)
            button.center = CGPointMake(160, 284 + 100)
            button.addTarget(self, action: "start", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(button)
        }
        
        
        let stopButton: AnyObject! = UIButton.buttonWithType(UIButtonType.System)
        if let button = stopButton as? UIButton
        {
            button.setTitle("stop", forState: UIControlState.Normal)
            button.frame = CGRectMake(0, 0, 50, 50)
            button.center = CGPointMake(160, 284 + 200)
            button.addTarget(self, action: "stop", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(button)
        }
        
    }
    
    // 监听方法
    func willResignActive()
    {
        println("resign active")
        if timer == nil
        {
            self.clearSharedData()
        }
        else
        {
            if timer!.isRunning
            {
                self.saveSharedData()
            }
            else
            {
                self.clearSharedData()
            }
        }
    }
    
    func start()
    {
        if let trueTimer = timer
        {
            trueTimer.start(totalTime)
        }
    }
    func stop()
    {
        if let trueTimer = timer
        {
            trueTimer.stop()
        }
    }
    func timerDidStop()
    {
        label!.text = "\(totalTime)"
    }
    func timerDidUpdate(remainTime:NSInteger)
    {
        label!.text = "\(remainTime)"
    }
    
    // MARK:
    // MARK: handle shared data
    func clearSharedData()
    {
        let userDefault = NSUserDefaults(suiteName: "group.develop")
        userDefault.removeObjectForKey("LeftTime")
        userDefault.removeObjectForKey("ThisTime")
        userDefault.synchronize()
    }
    func saveSharedData()
    {
        let userDefault = NSUserDefaults(suiteName: "group.develop")
        if timer
        {
            userDefault.setInteger(timer!.leftTime, forKey: "LeftTime")
            userDefault.setInteger(Int(NSDate().timeIntervalSince1970), forKey: "ThisTime")
        }
        userDefault.synchronize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

