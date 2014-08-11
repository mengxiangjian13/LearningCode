//
//  ViewController.swift
//  ShareExtension
//
//  Created by Xiangjian Meng on 14-8-11.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBOutlet weak var shareImage: UIImageView!
    
    @IBAction func share()
    {
        println("share!")
        
        var itemsToShare = [AnyObject]()
        
        itemsToShare.append("I found a BULL!!")
        
        if let image = shareImage.image {
            itemsToShare.append(image)
        }
        
        let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

