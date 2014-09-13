//
//  OverTransitioningDelegate.swift
//  PresentController
//
//  Created by Xiangjian Meng on 14-9-13.
//  Copyright (c) 2014年 Xiangjian Meng. All rights reserved.
//

import UIKit

class OverTransitioningDelegate: NSObject,UIViewControllerTransitioningDelegate
{
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController) -> UIPresentationController?
    {
        return PresentController(presentedViewController: presented, presentingViewController: presenting);
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        return BouncyViewControllerAnimator()
    }
}
