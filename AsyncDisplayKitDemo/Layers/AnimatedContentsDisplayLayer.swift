//
//  AnimatedContentsDisplayLayer.swift
//  Layers
//
//  Created by Xiangjian Meng on 14/11/24.
//  Copyright (c) 2014年 Razeware LLC. All rights reserved.
//

import UIKit

class AnimatedContentsDisplayLayer: _ASDisplayLayer {
    override func actionForKey(event: String!) -> CAAction! {
        if let action = super.actionForKey(event) {
            return action
        }
        
        if event == "contents" && contents == nil {
            let transition = CATransition()
            transition.duration = 0.6
            transition.type = kCATransitionFade
            return transition
        }
        
        return nil
    }

}
