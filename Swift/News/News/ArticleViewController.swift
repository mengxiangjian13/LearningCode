//
//  ArticleViewController.swift
//  News
//
//  Created by Xiangjian Meng on 14-7-30.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        
        let contentLabel = UILabel(frame: self.view.bounds);
        contentLabel.font = UIFont.systemFontOfSize(30)
        contentLabel.textColor = UIColor.blackColor()
        contentLabel.textAlignment = NSTextAlignment.Center
        contentLabel.numberOfLines = 0
        self.view.addSubview(contentLabel)
        if let titleString = self.title {
            contentLabel.text = "这篇文章的内容是：“文章\(titleString)的内容”，标题是：\(titleString)"
        }
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
