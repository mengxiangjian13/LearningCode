//
//  BouncyViewControllerAnimator.swift
//  PresentController
//
//  Created by Xiangjian Meng on 14-9-13.
//  Copyright (c) 2014年 Xiangjian Meng. All rights reserved.
//

import UIKit

class BouncyViewControllerAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.8
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if let presentedView = transitionContext.viewForKey(UITransitionContextToViewKey) {
            let centre = presentedView.center
            presentedView.center = CGPointMake(centre.x, -presentedView.bounds.size.height)
            transitionContext.containerView().addSubview(presentedView)
            
            UIView.animateWithDuration(self.transitionDuration(transitionContext),
                delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10.0, options: nil,
                animations: {
                    presentedView.center = centre
                }, completion: {
                    _ in
                    transitionContext.completeTransition(true)
            })
        }
    }
}
