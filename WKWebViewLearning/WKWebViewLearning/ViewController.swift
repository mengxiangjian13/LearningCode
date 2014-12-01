//
//  ViewController.swift
//  WKWebViewLearning
//
//  Created by Xiangjian Meng on 14/12/1.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    var webView : WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        webView = WKWebView(frame: CGRectMake(0, 64, view.bounds.width, view.bounds.height - 64));
        self.view.addSubview(webView)
        
        let url = NSURL(string: "http://www.baidu.com");
        if let realUrl = url{
            let request = NSURLRequest(URL: realUrl)
            webView.loadRequest(request)
        }
        
        let navigationBar = UIView(frame: CGRectMake(0, 0, view.bounds.width, 64))
        
        let backButton = buttonWithTitle("back", frame: CGRectMake(0, 20, 44, 44), selector: "back")
        navigationBar.addSubview(backButton);
        
        let forwardButton = buttonWithTitle("forward", frame: CGRectMake(60, 20, 44, 44), selector: "forward")
        navigationBar.addSubview(forwardButton);
        
        let logButton = buttonWithTitle("log", frame: CGRectMake(150, 20, 44, 44), selector: "logCurrentBackwardList")
        navigationBar.addSubview(logButton)
        
        view.addSubview(navigationBar)
    }
    
    func buttonWithTitle(title:String,frame:CGRect,selector:Selector)->UIButton{
        let button = UIButton.buttonWithType(.System) as UIButton
        button.frame = frame;
        button.addTarget(self, action: selector, forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitle(title, forState: UIControlState.Normal)
        return button
    }
    
    func back(){
        if webView.canGoBack{
            webView.goBack()
        }
    }
    
    func forward(){
        if webView.canGoForward{
            webView.goForward()
        }
    }
    
    func logCurrentBackwardList(){
        println(webView.backForwardList.backItem)
        println(webView.backForwardList.forwardItem)
        println(webView.backForwardList.currentItem)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

