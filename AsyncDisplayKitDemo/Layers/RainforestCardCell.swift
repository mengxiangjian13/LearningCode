//
//  RainforestCardCell.swift
//  Layers
//
//  Created by René Cacheaux on 9/1/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit

class RainforestCardCell: UICollectionViewCell {
  var featureImageSizeOptional: CGSize?
    var placeholderLayer : CALayer!
    var contentLayer : CALayer?
    var containerNode:ASDisplayNode?
    var nodeConstructionOperation:NSOperation?
  
  override func awakeFromNib() {
    super.awakeFromNib()
//    contentView.addSubview(backgroundImageView)
//    contentView.addSubview(featureImageView)
//    contentView.addSubview(gradientView)
//    contentView.addSubview(titleLabel)
//    contentView.addSubview(descriptionTextView)

    placeholderLayer = CALayer()
    placeholderLayer.contents = UIImage(named: "cardPlaceholder")!.CGImage
    placeholderLayer.contentsGravity = kCAGravityCenter
    placeholderLayer.contentsScale = UIScreen.mainScreen().scale
    placeholderLayer.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.85, alpha: 1).CGColor
    contentView.layer.addSublayer(placeholderLayer)
  }

  //MARK: Layout
  override func sizeThatFits(size: CGSize) -> CGSize {
    if let featureImageSize = featureImageSizeOptional {
      return FrameCalculator.sizeThatFits(size, withImageSize: featureImageSize)
    } else {
      return CGSizeZero
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
   
    CATransaction.begin()
    CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
    placeholderLayer.frame = bounds
    CATransaction.commit()
//    let featureImageSize = featureImageSizeOptional ?? CGSizeZero
//    
//    backgroundImageView.frame = FrameCalculator.frameForBackgroundImage(containerBounds: bounds)
//    featureImageView.frame = FrameCalculator.frameForFeatureImage(featureImageSize: featureImageSize,
//      containerFrameWidth: frame.size.width)
//    titleLabel.frame = FrameCalculator.frameForTitleText(containerBounds: bounds,
//      featureImageFrame: featureImageView.frame)
//    descriptionTextView.frame = FrameCalculator.frameForDescriptionText(containerBounds: bounds,
//      featureImageFrame: featureImageView.frame)
//    gradientView.frame = FrameCalculator.frameForGradient(featureImageFrame: featureImageView.frame)
  }
  
  //MARK: Cell Reuse
  override func prepareForReuse() {
    super.prepareForReuse()
    
    if let operation = nodeConstructionOperation
    {
        operation.cancel()
    }
    
    containerNode?.recursiveSetPreventOrCancelDisplay(true) // node取消绘制
    contentLayer?.removeFromSuperlayer()
    
    contentLayer = nil
    containerNode = nil
  }
  
  //MARK: Cell Content
    func configureCellDisplayWithCardInfo(cardInfo: RainforestCardInfo, nodeConstructionQueue:NSOperationQueue) {
    
    if let oldNodeConstructionOperation = nodeConstructionOperation {
        oldNodeConstructionOperation.cancel()
    }
    
    //MARK: Image Size Section
    let image = UIImage(named: cardInfo.imageName)!
    featureImageSizeOptional = image.size
    
    let newNodeConstructionOperation = nodeConstructionOperationWithCardInfo(cardInfo, image: image)
    nodeConstructionOperation = newNodeConstructionOperation
    nodeConstructionQueue.addOperation(newNodeConstructionOperation)
    
  }
    
    func nodeConstructionOperationWithCardInfo(cardInfo: RainforestCardInfo, image: UIImage) -> NSOperation {
        let nodeConstructionOperation = NSBlockOperation()
        nodeConstructionOperation.addExecutionBlock {
            // TODO: Add node hierarchy construction
            [weak self, unowned nodeConstructionOperation] in
            if nodeConstructionOperation.cancelled {
                return
            }
            if let strongSelf = self{
                //MARK: Node Creation Section
                let backgroundImageNode = ASImageNode()
                backgroundImageNode.image = image
                backgroundImageNode.contentMode = .ScaleAspectFill
                backgroundImageNode.layerBacked = true
                backgroundImageNode.imageModificationBlock = {
                    [weak backgroundImageNode] input in
                    if input == nil{
                        return input;
                    }
                    
                    // 是否取消模糊的渲染。如果node已经被移除就取消模糊渲染。
                    let didCancelBlur: () -> Bool = {
                        var isCancelled = true
                        // 1
                        if let strongBackgroundImageNode = backgroundImageNode {
                            // 2
                            let isCancelledClosure = {
                                isCancelled = strongBackgroundImageNode.preventOrCancelDisplay
                            }
                            
                            // 3
                            if NSThread.isMainThread() {
                                isCancelledClosure()
                            } else {
                                dispatch_sync(dispatch_get_main_queue(), isCancelledClosure)
                            }
                        }
                        return isCancelled
                    }
                    if let blurredImage = input.applyBlurWithRadius(
                        30,
                        tintColor: UIColor(white: 0.5, alpha: 0.3),
                        saturationDeltaFactor: 1.8,
                        maskImage: nil,
                        didCancel:didCancelBlur) {
                            return blurredImage
                    } else {
                        return image
                    }
                }
                //MARK: Container Node Creation Section
                let containerNode = ASDisplayNode(layerClass: AnimatedContentsDisplayLayer.self)
                containerNode.layerBacked = true
                containerNode.shouldRasterizeDescendants = true
                containerNode.borderColor = UIColor(hue: 0, saturation: 0, brightness: 0.85, alpha: 0.2).CGColor
                containerNode.borderWidth = 1
                containerNode.addSubnode(backgroundImageNode)
                
                let featureImageNode = ASImageNode()
                featureImageNode.layerBacked = true
                featureImageNode.contentMode = .ScaleAspectFit
                featureImageNode.image = image
                containerNode.addSubnode(featureImageNode)
                
                let titleTextNode = ASTextNode()
                titleTextNode.layerBacked = true
                titleTextNode.backgroundColor = UIColor.clearColor()
                titleTextNode.attributedString = NSAttributedString.attributedStringForTitleText(cardInfo.name)
                
                let descriptionTextNode = ASTextNode()
                descriptionTextNode.layerBacked = true
                descriptionTextNode.backgroundColor = UIColor.clearColor()
                descriptionTextNode.attributedString = NSAttributedString.attributedStringForDescriptionText(cardInfo.description)
                containerNode.addSubnode(descriptionTextNode)
                
                let gradientNode = GradientNode()
                gradientNode.opaque = false
                gradientNode.layerBacked = true
                containerNode.addSubnode(gradientNode)
                
                containerNode.addSubnode(titleTextNode)
                
                //MARK: Node Layout Section
                containerNode.frame = FrameCalculator.frameForContainer(featureImageSize: image.size)
                backgroundImageNode.frame = FrameCalculator.frameForBackgroundImage(containerBounds: containerNode.bounds)
                featureImageNode.frame = FrameCalculator.frameForFeatureImage(featureImageSize: image.size, containerFrameWidth: containerNode.frame.size.width)
                titleTextNode.frame = FrameCalculator.frameForTitleText(containerBounds: containerNode.bounds, featureImageFrame: featureImageNode.frame)
                descriptionTextNode.frame = FrameCalculator.frameForDescriptionText(containerBounds: containerNode.bounds, featureImageFrame: featureImageNode.frame)
                gradientNode.frame = FrameCalculator.frameForGradient(featureImageFrame: featureImageNode.frame)
                
                //MARK: Node Layer and Wrap Up Section
                dispatch_async(dispatch_get_main_queue()) { [weak nodeConstructionOperation] in
                    if let strongNodeConstructionOperation = nodeConstructionOperation {
                        // 2
                        if strongNodeConstructionOperation.cancelled {
                            return
                        }
                        
                        // 3
                        if strongSelf.nodeConstructionOperation !== strongNodeConstructionOperation {
                            return
                        }
                        
                        // 4
                        if containerNode.preventOrCancelDisplay {
                            return
                        }
                        
                        // 5
                        //MARK: Node Layer and Wrap Up Section
                        strongSelf.contentView.layer.addSublayer(containerNode.layer)
                        containerNode.setNeedsDisplay()
                        strongSelf.contentLayer = containerNode.layer
                        strongSelf.containerNode = containerNode
                    }
                }
            }
        }
        return nodeConstructionOperation
    }
  
}
