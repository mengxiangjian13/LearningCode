//
//  TableViewController.swift
//  SwiftTest
//
//  Created by Xiangjian Meng on 14-6-18.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit

class TableViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tableView : UITableView = UITableView(frame:self.view.bounds,style:.Plain)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let identifier = "cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? UITableViewCell
        
        if cell == nil{
            cell = UITableViewCell(style:.Default,reuseIdentifier:identifier)
        }
        
        cell!.textLabel.text = "好的"
        
        return cell;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
