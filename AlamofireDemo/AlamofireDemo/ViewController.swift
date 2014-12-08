//
//  ViewController.swift
//  AlamofireDemo
//
//  Created by Xiangjian Meng on 14/12/4.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit
import Alamofire

class WeatherObject{
    var temperature : NSNumber
    init(temperature:NSNumber){
        self.temperature = temperature
    }
}

// 自定义Serializer。将NSData改换成Weather对象
extension Alamofire.Request{
    class func objectResponseSerializer() -> Serializer {
        return { request, response, data in
            if data == nil {
                return (nil,nil)
            }
            
            var error : NSErrorPointer = nil
            
            let dict: AnyObject? =  NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments, error: error)
            
            if let d = dict as? NSDictionary {
                let main : AnyObject? = d["main"]
                if let t = main as? NSDictionary {
                    let temperature: AnyObject? = t["temp"]
                    if let temp = temperature as? NSNumber {
                        let weather = WeatherObject(temperature: temp)
                        return (weather,nil)
                    }
                }
            }
            
            return (nil,error.memory)
        }
    }
    
    func responseWeather(completionHandler: (NSURLRequest, NSHTTPURLResponse?, WeatherObject?, NSError?) -> Void) -> Self {
        return response(serializer: Request.objectResponseSerializer()){
            request,response,data,error in
            completionHandler(request,response,data as? WeatherObject,error)
        }
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Alamofire.request(.GET,"http://api.openweathermap.org/data/2.5/weather?lat=40&lon=116&units=imperial").responseJSON(){
            (_,_,data,_) in println(data)
        }
        
        Alamofire.request(.GET, "http://api.openweathermap.org/data/2.5/weather?lat=40&lon=116&units=imperial").responseWeather() {
            (_,_,data,_) in println("temp:\(data?.temperature)")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

