//
//  ViewController.swift
//  ForceTouchDemo
//
//  Created by Xiangjian Meng on 15/10/21.
//  Copyright © 2015年 mengxiangjian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, UIViewControllerPreviewingDelegate {
    
    let tableView = UITableView()
    let names = ["张磊","林溢泽","王立群","孟祥建"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.translucent = false;
        
        self.title = "Force Touch Demo"
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height)
        view.addSubview(tableView)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        }
        cell?.textLabel?.text = names[indexPath.row]
        
        if traitCollection.forceTouchCapability == UIForceTouchCapability.Available {
            registerForPreviewingWithDelegate(self, sourceView: cell!)
        }
        
        return cell!
    }
    
    // 预览delegate方法 第一个方法为预览时调用，返回预览的viewController
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
//        guard let indexPath = tableView.indexPathForRowAtPoint(location),
//            cell = tableView.cellForRowAtIndexPath(indexPath)
//            else {return nil}
        let cell = previewingContext.sourceView as! UITableViewCell
        
        let detailViewController = DetailViewController()
        detailViewController.text = cell.textLabel!.text!
        return detailViewController
    }
    
    // 继续force touch就会直接显示
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        showViewController(viewControllerToCommit, sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

