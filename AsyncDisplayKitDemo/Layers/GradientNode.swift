//
//  GradientNode.swift
//  Layers
//
//  Created by Xiangjian Meng on 14/11/24.
//  Copyright (c) 2014年 Razeware LLC. All rights reserved.
//

import UIKit

class GradientNode: ASDisplayNode {
   
    class func drawRect(bounds: CGRect, withParameters parameters: NSObjectProtocol!,
        isCancelled isCancelledBlock: asdisplaynode_iscancelled_block_t!, isRasterizing: Bool) {
            let myContext = UIGraphicsGetCurrentContext()
            CGContextSaveGState(myContext)
            CGContextClipToRect(myContext, bounds)
            
            let componentCount: UInt = 2
            let locations: [CGFloat] = [0.0, 1.0]
            let components: [CGFloat] = [0.0, 0.0, 0.0, 1.0,
                0.0, 0.0, 0.0, 0.0]
            let myColorSpace = CGColorSpaceCreateDeviceRGB()
            let myGradient = CGGradientCreateWithColorComponents(myColorSpace, components,
                locations, componentCount)
            
            let myStartPoint = CGPoint(x: bounds.midX, y: bounds.maxY)
            let myEndPoint = CGPoint(x: bounds.midX, y: bounds.midY)
            CGContextDrawLinearGradient(myContext, myGradient, myStartPoint,
                myEndPoint, UInt32(kCGGradientDrawsAfterEndLocation))
            
            CGContextRestoreGState(myContext)
    }
    
    
}
