//
//  GradientView.swift
//  Layers
//
//  Created by René Cacheaux on 10/18/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit

class GradientView: UIView {

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    backgroundColor = UIColor.clearColor()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.clearColor()
  }
  
  override convenience init() {
    self.init(frame: CGRectZero)
  }
  
  override func drawRect(rect: CGRect) {
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
