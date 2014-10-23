//
//  CaptureView.swift
//  AvatarCaptureView
//
//  Created by Xiangjian Meng on 14/10/23.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

import UIKit

class CaptureView: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        let contextRef = UIGraphicsGetCurrentContext();
        CGContextSaveGState(contextRef);
        CGContextSetRGBFillColor(contextRef, 0, 0, 0, 0.35);//填充颜色为黑色透明
        CGContextSetLineWidth(contextRef, 3);
        
        // 圆的直径
        let d = rect.width < rect.height ? (rect.width - 100) : (rect.height - 100);
        // 创建圆形path
        let roundPath = UIBezierPath(arcCenter: self.center, radius: d/2.0, startAngle: 0, endAngle: 2*CGFloat(M_PI), clockwise: true);
        // 创建整个view的path
        let viewPath = UIBezierPath(rect: rect);
        // 将圆形path添加到整个path上，然后填充中间颜色
        viewPath.appendPath(roundPath);
        viewPath.usesEvenOddFillRule = true;
        viewPath.fill();
        
        // 添加虚线
        CGContextSetLineWidth(contextRef, 2);
        CGContextSetRGBStrokeColor(contextRef, 255, 0, 0, 1);
        let dd = [CGFloat(4.0),CGFloat(4.0)];
        roundPath.setLineDash(dd, count: 2, phase: 0);
        roundPath.stroke();
        CGContextRestoreGState(contextRef);
        
        self.layer.contentsGravity = kCAGravityCenter;
    }
    

}
