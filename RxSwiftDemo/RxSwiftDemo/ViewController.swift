//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by mengxiangjian on 16/1/14.
//  Copyright © 2016年 mengxiangjian. All rights reserved.
//

import UIKit
import RxSwift
//import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var a = [1,2,3,4,5,6]
        a.append(7)
        a.toObservable().subscribeNext {
            x in
            print(x)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

