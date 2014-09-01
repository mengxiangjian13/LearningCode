//
//  ViewController.swift
//  CIDetector
//
//  Created by Xiangjian Meng on 14-8-27.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var detector : CIDetector? = nil;
    
    let isRectangle = false;
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let button = UIButton.buttonWithType(.System) as UIButton;
        button.enabled = false;
        button.frame = CGRectMake(0, 0, 50, 50);
        button.center = self.view.center;
        button.setTitle("ok", forState: UIControlState.Normal)
        self.view.addSubview(button);
        
        
        
        // 检查矩形
        // option: 准确性， 相对比例（长宽比）
        
//        if isRectangle
//        {
//            detector = rectangleDetector();
////            performRectangleDetection()
//        }
//        else
//        {
//            detector = qrCodeDetector();
//        }
        
    }
    
//    func rectangleDetector()->CIDetector/Users/huangtiezhu/Desktop/LearningCode/iOS8/CIDetector/CIDetector/ViewController.swift
//    {
//        let options = [CIDetectorAccuracy : CIDetectorAccuracyHigh, CIDetectorAspectRatio : 2.0];
//         return CIDetector(ofType: CIDetectorTypeRectangle, context: nil, options: options);
//    }
//    
//    func qrCodeDetector()->CIDetector
//    {
//        let option = [CIDetectorAccuracy : CIDetectorAccuracyHigh];
//        return CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: option);
//    }
    
    
//    // 找到矩形
//    func performRectangleDetection(image:CIImage) -> CIImage?
//    {
//        var resultImage : CIImage? = nil;
//        
//        if let detector = detector
//        {
//            var features = detector.featuresInImage(image);
//            
//            for feature in features as [CIRectangleFeature]
//            {
//                // 找到了矩形feature,这个feature里面包含了矩形的bounds，还有矩形的四个点
//                // 按照这四个点画一个边
//                 resultImage = drawHighlightedOverlayForPoint(image, topLeft: feature.topLeft, topRight: feature.topRight, bottomLeft: feature.bottomLeft, bottomRight: feature.bottomRight);
//            }
//        }
//        
//        return resultImage;
//    }
//    
//    // 找到二维码
//    func performQRCodesDetection(image:CIImage)->(CIImage?,String?)
//    {
//        var resultImage : CIImage? = nil;
//        var codeString : String? = nil;
//        
//        if let detector = detector
//        {
//            var features = detector.featuresInImage(image);
//            
//            for feature in features as [CIBarcodeFeature]
//            {
//                resultImage = drawHighlightedOverlayForPoint(image, topLeft: feature.topLeft, topRight: feature.topRight, bottomLeft: feature.bottomLeft, bottomRight: feature.bottomRight);
//                codeString = feature.codeString;
//            }
//        }
//        
//        return (resultImage,codeString);
//    }
//    
//    
//    // 在找到的feature上面加一层红色的滤镜
//    func drawHighlightedOverlayForPoint(image:CIImage,topLeft:CGPoint,topRight:CGPoint,bottomLeft:CGPoint,bottomRight:CGPoint) -> CIImage
//    {
//        // 创建红色的CIImage
//        var overlay = CIImage(color: CIColor(red: 1.0, green: 0, blue: 0, alpha: 0.5));
//        
//        overlay = overlay.imageByCroppingToRect(image.extent())
//        overlay = overlay.imageByApplyingFilter("CIPerspectiveTransformWithExtent", withInputParameters: [
//            
//            "inputExtent" : CIVector(CGRect: image.extent()),
//            "inputTopLeft" : CIVector(CGPoint: topLeft),
//            "inputTopRight" : CIVector(CGPoint: topRight),
//            "inputBottomLeft" : CIVector(CGPoint: bottomLeft),
//            "inputBottomRight" : CIVector(CGPoint: bottomRight),
//            
//            ]);
//        
//        return overlay.imageByCompositingOverImage(image);
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

