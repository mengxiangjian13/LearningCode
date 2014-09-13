//
//  PresentController.swift
//  PresentController
//
//  Created by Xiangjian Meng on 14-9-13.
//  Copyright (c) 2014年 Xiangjian Meng. All rights reserved.
//

import UIKit

class PresentController: UIPresentationController {
    
    let dimingView = UIView();
    
    override init(presentedViewController: UIViewController!, presentingViewController: UIViewController!)
    {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController);
        
        dimingView.backgroundColor = UIColor(white: 0, alpha: 0.5);
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect
    {
        // 弹出的view的frame
        return containerView.bounds.rectByInsetting(dx: 30, dy: 30);
    }
    
    override func presentationTransitionWillBegin()
    {
        // 弹出的开始
        // 显示黑色底
        let rect = containerView.bounds;
        dimingView.frame = rect;
        containerView.insertSubview(dimingView, atIndex: 0);
        dimingView.alpha = 0;
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({
            context in self.dimingView.alpha = 1
            }, completion: nil);
    }
    
    override func dismissalTransitionWillBegin()
    {
        // 降下的开始
        
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({
            _ in self.dimingView.alpha = 0.0;
            }, completion: {_ in self.dimingView.removeFromSuperview()});
    }
    
    // containerView 开始话子视图的时候调用，旋转后也会调用。
    override func containerViewWillLayoutSubviews()
    {
        dimingView.frame = containerView.bounds;
        presentedView().frame = frameOfPresentedViewInContainerView();
        
        if let vc = presentedViewController as? SecondViewController
        {
            vc.rotateDidFinish();
        }
    }
}
