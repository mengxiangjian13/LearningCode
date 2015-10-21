//
//  DetailViewController.swift
//  ForceTouchDemo
//
//  Created by Xiangjian Meng on 15/10/21.
//  Copyright © 2015年 mengxiangjian. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var text = "";

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "详细信息"
        
        view.backgroundColor = UIColor.whiteColor()
        
        // Do any additional setup after loading the view.
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        label.textAlignment = .Center
        label.text = text
        label.center = view.center
        view.addSubview(label)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.backBarButtonItem?.title = "返回"
    }
    
    override func previewActionItems() -> [UIPreviewActionItem] {
        
        let itemShare = UIPreviewAction(title: "分享", style: UIPreviewActionStyle.Default) {
            previewAction, viewController in
            
            let alertView = UIAlertView(title: "分享", message: "分享内容", delegate: nil, cancelButtonTitle: "确定")
            alertView.show()
            
        }
        
        return [itemShare]
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
