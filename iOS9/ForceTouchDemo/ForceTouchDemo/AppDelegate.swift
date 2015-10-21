//
//  AppDelegate.swift
//  ForceTouchDemo
//
//  Created by Xiangjian Meng on 15/10/21.
//  Copyright © 2015年 mengxiangjian. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // 通过shortcut进来的入口
        let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem
        
        if let _ = shortcutItem {
//            shortcutItem 
            print(shortcutItem)
            
//            let alert = UIAlertView(title: shortcutItem?.localizedTitle, message: shortcutItem?.localizedSubtitle,
//                delegate: nil, cancelButtonTitle: "ok")
//            alert.show()
        }
        
        if let items = application.shortcutItems where items.isEmpty {
            // 动态添加shortcut
            
            let item = UIApplicationShortcutItem(type: "com.mengxiangjian.ForceTouchDemo.second", localizedTitle: "查看孟祥建", localizedSubtitle: "孟祥建", icon: UIApplicationShortcutIcon(type: .Location), userInfo: nil)
            application.shortcutItems = [item]
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        
        // 通过shortcut进来的入口
        print(shortcutItem)
        let alert = UIAlertView(title: shortcutItem.localizedTitle, message: shortcutItem.localizedSubtitle,
            delegate: nil, cancelButtonTitle: "ok")
        alert.show()
        
        completionHandler(true)
    }

}

