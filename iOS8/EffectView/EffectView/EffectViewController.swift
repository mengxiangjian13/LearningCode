//
//  EffectViewController.swift
//  EffectView
//
//  Created by Xiangjian Meng on 14-8-12.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit

class EffectViewController: UIViewController {

    // blurView和vibrancyView装换开关
    let _switch = false
    
    var slider : UISlider? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.clearColor()
        
        slider = UISlider(frame: CGRectMake(10, 20, 300, 30))
        slider!.userInteractionEnabled = true
        slider!.continuous = true
        slider!.value = 0.5
        
        if _switch
        {
            let blurView = self.createBlurVisualEffectView()
            view.addSubview(blurView)
        }
        else
        {
            let vibrancyView = self.createVibrancyEffectView()
            view.addSubview(vibrancyView)
        }
        
        
        
        let button: AnyObject! = UIButton.buttonWithType(UIButtonType.System)
        if let b = button as? UIButton
        {
            b.frame = CGRectMake(0, 0, 100, 100)
            b.setTitle("关闭毛玻璃", forState: .Normal)
            b.center = CGPointMake(160, 500)
            b.addTarget(self, action: "close", forControlEvents: UIControlEvents.TouchUpInside)
            view.addSubview(b)
        }
    }
    
    // blurEffect
    func createBlurVisualEffectView() -> UIVisualEffectView
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = CGRectMake(0, 200, self.view.bounds.size.width, self.view.bounds.size.height - 200)
        // UIVisualEffectView 添加子view必须在contentView上加
        blurEffectView.contentView.addSubview(self.slider!)
        return blurEffectView
    }
    
    // vibrancyEffect
    func createVibrancyEffectView() -> UIVisualEffectView
    {
        // 创建vibrancyEffect,必须先创建一个blurEffect
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        let vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 200)
        // UIVisualEffectView 添加子view必须在contentView上加
        vibrancyEffectView.contentView.addSubview(self.slider!)
        blurEffectView.frame = CGRectMake(0, 200, self.view.bounds.size.width, self.view.bounds.size.height - 200)
        blurEffectView.contentView.addSubview(vibrancyEffectView)
        return blurEffectView
    }
    
    func close()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
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
