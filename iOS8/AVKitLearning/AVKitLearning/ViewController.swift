//
//  ViewController.swift
//  AVKitLearning
//
//  Created by Xiangjian Meng on 14-9-28.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Photos

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 获取video资源
        let videos = PHAsset.fetchAssetsWithMediaType(.Video, options: nil);
        let imageManager = PHImageManager.defaultManager();
        var playerItems = [AVPlayerItem]();
        
        // 请求video的playerItem
        videos.enumerateObjectsWithOptions(nil, usingBlock: { (video, index, _) -> Void in
            if let ff = video as? PHAsset
            {
                imageManager.requestPlayerItemForVideo(ff, options: nil, resultHandler: { (playerItem, _) -> Void in
                    playerItems.append(playerItem);
                });
            }
        })
        
        for playerItem in playerItems
        {
            // 根据playerItem生成相应的avplayer
            let avPlayer = AVPlayer(playerItem: playerItem);
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowMovie"
        {
            let movieVC : AnyObject = segue.destinationViewController;
            if let vc = movieVC as? AVPlayerViewController
            {
                let url = NSURL(string: "http://v.cdn.bb.bbwc.cn/bloomberg/2014/09/27/20140927095414901/20140927095414901_index.m3u8");
                vc.player = AVPlayer(URL: url);
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

