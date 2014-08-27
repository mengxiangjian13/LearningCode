//
//  ViewController.swift
//  KeyboardExtension
//
//  Created by Xiangjian Meng on 14-8-25.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let textField = UITextField(frame: CGRectMake(0, 0, 300, 50))
        textField.autocapitalizationType = UITextAutocapitalizationType.None
        textField.autocorrectionType = UITextAutocorrectionType.No
        textField.center = self.view.center
        textField.borderStyle = .Line
        self.view.addSubview(textField)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

