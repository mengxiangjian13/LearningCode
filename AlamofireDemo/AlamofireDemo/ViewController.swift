//
//  ViewController.swift
//  AlamofireDemo
//
//  Created by Xiangjian Meng on 14/12/4.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Alamofire.request(.GET,"http://api.openweathermap.org/data/2.5/weather?lat=40&lon=116&units=imperial").responseJSON(){
            (_,_,data,_) in println(data)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

