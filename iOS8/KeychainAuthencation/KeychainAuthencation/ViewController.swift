//
//  ViewController.swift
//  KeychainAuthencation
//
//  Created by Xiangjian Meng on 14-10-8.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let keychainManager = KeychainManager();
    var textField : UITextField! = nil;
    var label : UILabel! = nil;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let viewWidth = self.view.bounds.size.width;
        
        // 添加textField
        textField = UITextField(frame: CGRectMake(20, 50, viewWidth - 40, 30));
        textField.autocapitalizationType = .None;
        textField.autocorrectionType = .No;
        textField.placeholder = "enter your secret";
        textField.borderStyle = .Line;
        textField.textAlignment = NSTextAlignment.Center;
        textField.textColor = UIColor.blackColor();
        self.view.addSubview(textField);
        
        
        // 保存按钮
        let saveButton = UIButton.buttonWithType(.System) as UIButton;
        saveButton.frame = CGRectMake(0, 0, 100, 50);
        saveButton.setTitle("save", forState: .Normal);
        saveButton.center = CGPointMake(viewWidth/2.0, 120);
        saveButton.addTarget(self, action: "save", forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(saveButton);
        
        // 展示secret的label
        label = UILabel(frame: CGRectMake(0, 200, viewWidth, 50));
        label.textAlignment = .Center;
        label.backgroundColor = UIColor.yellowColor();
        label.textColor = UIColor.blackColor();
        self.view.addSubview(label);

        // 显示secret按钮
        let showSecretButton = UIButton.buttonWithType(.System) as UIButton;
        showSecretButton.frame = CGRectMake(0, 0, 100, 50);
        showSecretButton.center = CGPointMake(viewWidth/2.0, 290);
        showSecretButton.setTitle("show", forState: .Normal);
        showSecretButton.addTarget(self, action: "show", forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(showSecretButton);
        
    }
    
    func save()
    {
        println("保存\(textField.text)");
        
        keychainManager.savedSecret = textField.text;
    }
    
    func show()
    {
        println("显示密码");
        
        label.text = keychainManager.savedSecret;
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

