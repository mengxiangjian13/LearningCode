//
//  ViewController.swift
//  AVCaptureVideoImage
//
//  Created by Xiangjian Meng on 14-10-21.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

/*
    工程目的是学习从ALAssetsLibrary中获取视频的URL，然后通过AVFoundation截取视频特定位置的截图。
*/

import UIKit
import AVFoundation
import AssetsLibrary

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var timeSlider: UISlider!
    
    var videoURLArray = [NSURL]();

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //初始化控件
        timeSlider.value = 0.5;
        imageView.image = nil;
        
        // 给slider设置动作,变更不同的时间位置获取不同时间位置的截图
        timeSlider.addTarget(self, action: "changeTime", forControlEvents: UIControlEvents.ValueChanged);
        
        // 通过assetsLibrary寻找视频
        let assetsLibrary = ALAssetsLibrary();
        assetsLibrary.enumerateGroupsWithTypes(Int(ALAssetsGroupSavedPhotos), usingBlock: { (group:ALAssetsGroup!, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            // 有library group
            if group != nil // 因为遍历到最后为nil，所以要判断是否为空
            {
                group.setAssetsFilter(ALAssetsFilter.allVideos());// 只取视频
                
                if group.numberOfAssets() > 0
                {
                    let indexset = NSMutableIndexSet(index: 0);
                    //遍历group里面的asset
                    group.enumerateAssetsAtIndexes(indexset, options: NSEnumerationOptions(0)){ (asset:ALAsset!, index:Int, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
                        if asset != nil
                        {
                            println("检测视频中");
                            let representation = asset.defaultRepresentation();// 这里面有URL
                            let url = representation.url();
                            self.videoURLArray.append(url);
                        }
                        else
                        {
                            // asset == nil 说明已经遍历完成
                            println("检测视频完毕");
                            self.captureImageFromVideoWithURL(self.videoURLArray);
                        }
                    }
                }
            }
            
            }) { (error:NSError!) -> Void in
            // 无library group
                println("没有library");
        }
        
    }
    
    func captureImageFromVideoWithURL(videoURLArray:[NSURL])
    {
        if videoURLArray.count > 0
        {
            // 默认先取第一个视频 注意是AVAsset
            let firstUrl : NSURL = videoURLArray[0];
            let avAsset = AVAsset.assetWithURL(firstUrl) as AVAsset;
            
            // 检查是否有video轨道,有说明是视频
            if avAsset.tracksWithMediaType(AVMediaTypeVideo).count > 0
            {
                // 建立图片生成器
                let imageGenerator = AVAssetImageGenerator(asset: avAsset);
                // 生成图片
                let duration = CMTimeGetSeconds(avAsset.duration);// 视频duration
                let timeLine = Float64(self.timeSlider.value) * duration;// 具体截图的时间位置
                let cmtime:CMTime = CMTimeMakeWithSeconds(timeLine, 600);
                imageGenerator.generateCGImagesAsynchronouslyForTimes([NSValue(CMTime: cmtime)]){ (time:CMTime, image:CGImage!, actualTime:CMTime, result:AVAssetImageGeneratorResult, error:NSError!) -> Void in
                    // 异步请求一组截图，但每一个截图返回都会调用这个闭包，N个截图就会调用N次，所以返回参数中image是CGImage而不是一个数组
                    if result == .Succeeded
                    {
                        dispatch_async(dispatch_get_main_queue()){
                            let uiimage = UIImage(CGImage: image)
                            self.imageView.image = uiimage;
                        };
                    }
                }
            }
            
        }
    }
    
    func changeTime()
    {
        if self.videoURLArray.count > 0
        {
            self.captureImageFromVideoWithURL(self.videoURLArray);
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

