//
//  ViewController.swift
//  KingfisherDemo
//
//  Created by mengxiangjian on 15/12/8.
//  Copyright © 2015年 mengxiangjian. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 单纯通过url设置image
        imageView.kf_setImageWithURL(NSURL(string: "http://down.tutu001.com/d/file/20101129/2f5ca0f1c9b6d02ea87df74fcc_560.jpg")!)
        
        // 通过url设置image，并同时设置placeholder
        imageView1.kf_setImageWithURL(NSURL(string: "http://down.tutu001.com/d/file/20101129/2f5ca0f1c9b6d02ea87df74fcc_560.jpg")!, placeholderImage: nil)
        
        // 通过设置url设置image，并增加选项option
        imageView2.kf_setImageWithURL(NSURL(string: "http://pic.nipic.com/2007-11-09/2007119122519868_2.jpg")!,
            placeholderImage: nil, optionsInfo: [.Transition(ImageTransition.Fade(1))])
        
        // 操作downloader和cache
//        KingfisherManager.sharedManager.downloader
//        KingfisherManager.sharedManager.cache
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

