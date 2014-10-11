//
//  ShareViewController.swift
//  SimpleShare
//
//  Created by Xiangjian Meng on 14-8-11.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {
    
    let maxContentTextLength = 20
    
    var sharingImage : UIImage? = nil

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        
        if let content = contentText
        {
            let length = countElements(content)
            charactersRemaining = maxContentTextLength - length
            if Int(charactersRemaining) < 0
            {
                return false
            }
        }
        
        return true
    }
    
    override func presentationAnimationDidFinish()
    {
        // 此方法会在分享编辑界面动画完成的时候调用
        // 在这个方法里面实现比较heavy的任务，比如检查是否有image
        
        let extensionItem = self.extensionContext!.inputItems[0] as NSExtensionItem
        fetchSharingImage(extensionItem)
        {
            image in self.sharingImage = image
        }
    }
    
    func fetchSharingImage(extensionItem : NSExtensionItem,callback : (image:UIImage?) -> Void)
    {
        for attachment in extensionItem.attachments as [NSItemProvider]
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
            {
                if attachment.hasItemConformingToTypeIdentifier(kUTTypeImage as NSString)
                {
                    attachment.loadItemForTypeIdentifier(kUTTypeImage as NSString, options: nil)
                    {
                        (provider,error) in
                        var image : UIImage? = nil
                        if let e = error
                        {
                            println("load image error:\(e.localizedDescription)")
                            return
                        }
                        image = provider as? UIImage
                        dispatch_async(dispatch_get_main_queue())
                        {
                            callback(image: image)
                        }
                    }
                }
            }
        }
    }
    
    override func configurationItems() -> [AnyObject]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        
//         可以添加诸如地理信息等，返回一个 SLComposeSheetConfigurationItem 的数组
        return NSArray()
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
        
        // 点击发送，就可以post文字和图片到设定好的地方
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequestReturningItems(nil, completionHandler: nil)
    }

}
