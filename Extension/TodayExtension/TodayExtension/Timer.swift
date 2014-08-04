//
//  Timer.swift
//  TodayExtension
//
//  Created by Xiangjian Meng on 14-8-4.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit

public protocol TimerDelegate
{
    func timerDidStop()
    func timerDidUpdate(remainTime:NSInteger)
}

public class Timer: NSObject {
    
    public var isRunning = false
    var timer : NSTimer?
    public var leftTime : NSInteger = 0
    var delegate : TimerDelegate?
    
    public init(delegate:TimerDelegate?)
    {
        super.init()
        self.delegate = delegate
    }
    
    deinit
    {
        self.delegate = nil
    }
    
    public func start(totalTime:NSInteger)
    {
        if totalTime > 0
        {
            self.leftTime = totalTime
        }
        
        if timer == nil
        {
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerCount", userInfo: nil, repeats: true)
        }
    }
    
    public func stop()
    {
        isRunning = false
        timer!.invalidate()
        timer = nil
        // 剩余时间等于0
        if let timerDelegate =  self.delegate
        {
            timerDelegate.timerDidStop()
        }
    }
    
    // 计时器方法
    func timerCount()
    {
        self.leftTime -= 1
        
        if self.leftTime != 0
        {
            // 剩余时间大于0
            isRunning = true
            
            if let timerDelegate =  self.delegate
            {
                timerDelegate.timerDidUpdate(self.leftTime)
            }
        }
        else
        {
            self.stop()
        }
    }
    
}
