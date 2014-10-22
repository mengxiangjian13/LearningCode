//
//  ViewController.swift
//  News
//
//  Created by Xiangjian Meng on 14-7-28.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "新闻"
        
        // 登录按钮
        let loginButton: AnyObject! = UIButton.buttonWithType(.System)
        if let button = loginButton as? UIButton
        {
            button.frame = CGRectMake(0, 0, 44, 44)
            button.setTitle("登录", forState: UIControlState.Normal)
            button.addTarget(self, action: "login", forControlEvents:UIControlEvents.TouchUpInside)
            
            let leftItem = UIBarButtonItem(customView: button)
            self.navigationItem.rightBarButtonItem = leftItem
        }
        
        // 加载表格
        let tableView = UITableView(frame: self.view.bounds, style: .Plain)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    func login()
    {
        println("登录")
        let loginVC = LoginViewController()
        let loginNVC = UINavigationController(rootViewController: loginVC)
        self.navigationController!.presentViewController(loginNVC, animated: true, completion: {println("弹出登录框")})
    }
    
    var titleArray = ["1","2","3","4","5"]
    
    
    //MARK:-
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return titleArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? UITableViewCell
        if cell == nil
        {
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        }
        
        cell!.textLabel.text = titleArray[indexPath.row]
        
        return cell!
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        let articleViewController = ArticleViewController()
        articleViewController.title = titleArray[indexPath.row]
        self.navigationController!.pushViewController(articleViewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

