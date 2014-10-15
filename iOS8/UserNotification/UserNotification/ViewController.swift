//
//  ViewController.swift
//  UserNotification
//
//  Created by Xiangjian Meng on 14-10-15.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func sendNotification()
    {
        let localNoti = UILocalNotification();
        localNoti.timeZone = NSTimeZone.defaultTimeZone()
        localNoti.alertBody = "是否打开应用？";
        localNoti.fireDate = NSDate(timeIntervalSinceNow: 5);
        localNoti.category = "alert";
        UIApplication.sharedApplication().scheduleLocalNotification(localNoti);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let category = UIMutableUserNotificationCategory();
        category.identifier = "alert";
        
        let enterAction = UIMutableUserNotificationAction();
        enterAction.identifier = "enter";
        enterAction.activationMode = .Foreground; // 前台处理
        enterAction.title = "进入";
        
        let rejectAction = UIMutableUserNotificationAction();
        rejectAction.identifier = "reject";
        rejectAction.activationMode = .Background; // 后台处理
        rejectAction.authenticationRequired = true; // background mode 最好需要一下密码或者指纹验证，Foreground设置此属性没有用。
        rejectAction.title = "拒绝";
        
        category.setActions([enterAction,rejectAction], forContext: UIUserNotificationActionContext.Minimal);
        
        let settings = UIUserNotificationSettings(forTypes: (.Alert | .Badge | .Sound), categories: NSSet(object: category));
        UIApplication.sharedApplication().registerUserNotificationSettings(settings);
        
        
    }
    
    func showEnterAlert()
    {
        let avc = UIAlertController(title: "进来了！", message: "终于进来了！", preferredStyle: UIAlertControllerStyle.Alert);
        let action = UIAlertAction(title: "知道了", style: UIAlertActionStyle.Default, handler: {_ in
            // 这里是action触发的动作。不用像以前alertView实现代理方法了。
        });
        avc.addAction(action);
        self.presentViewController(avc, animated: true, completion: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

