//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by mengxiangjian on 16/1/14.
//  Copyright © 2016年 mengxiangjian. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let observer = self.requestObservable("http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=2de143494c0b295cca9337e1e96b00e0")
        observer.subscribe(onNext: { json in
            print(json)
            }, onError: { error in
                print(error)
            }, onCompleted: {
                print("finish!")
            }) {
                
        }
        
    }
    
    func requestObservable(url:String) -> Observable<AnyObject> {
        return Observable.create({ observer -> Disposable in
            let req = Alamofire.request(.GET, url)
            req.responseJSON(completionHandler: {response -> Void in
                switch response.result {
                case Alamofire.Result.Success(let json):
                    observer.on(RxSwift.Event.Next(json))
                    observer.on(RxSwift.Event.Completed)
                case Alamofire.Result.Failure(let error):
                    observer.on(RxSwift.Event.Error(error))
                }
            })
            return AnonymousDisposable {
                req.cancel()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

