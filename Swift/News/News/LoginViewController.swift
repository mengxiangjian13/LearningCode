//
//  LoginViewController.swift
//  News
//
//  Created by Xiangjian Meng on 14-7-30.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "登录"
        self.view.backgroundColor = UIColor.whiteColor()
        
        let rightItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancel")
        self.navigationItem.rightBarButtonItem = rightItem
        
//        let loginButton: AnyObject! = UIButton.buttonWithType(.System)
//        if let button = loginButton as? UIButton
//        {
//            button.frame = CGRectMake(0, 300, 44, 44)
//            button.setTitle("登录", forState: UIControlState.Normal)
//            button.addTarget(self, action: "login", forControlEvents:UIControlEvents.TouchUpInside)
//            self.view.addSubview(button)
//        }
        
        let loginButton: AnyObject! = UIButton.buttonWithType(.System)
        if let button = loginButton as? UIButton
        {
            button.frame = CGRectMake(130, 300, 50, 50);
            button.setTitle("登录", forState: UIControlState.Normal)
            button.addTarget(self, action: "login", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(button)
        }
    }
    
    func cancel()
    {
        self.navigationController.dismissViewControllerAnimated(true, completion: {println("关闭登录框")})
    }
    
    func login()
    {
        let alert = UIAlertView(title: "登录成功！", message: nil, delegate: nil, cancelButtonTitle: "知道了！")
        alert.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
