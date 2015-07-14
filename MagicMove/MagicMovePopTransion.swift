//
//  MagicMovePopTransion.swift
//  MagicMove
//
//  Created by BourneWeng on 15/7/13.
//  Copyright (c) 2015年 Bourne. All rights reserved.
//

import UIKit

class MagicMovePopTransion: NSObject, UIViewControllerAnimatedTransitioning {
   
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! DetailViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! ViewController
        let container = transitionContext.containerView()
        
        let snapshotView = fromVC.avatarImageView.snapshotViewAfterScreenUpdates(false)
        snapshotView.frame = container.convertRect(fromVC.avatarImageView.frame, fromView: fromVC.view)
        fromVC.avatarImageView.hidden = true
        
        toVC.view.frame = transitionContext.finalFrameForViewController(toVC)
        toVC.selectedCell.imageView.hidden = true
        
        container.insertSubview(toVC.view, belowSubview: fromVC.view)
        container.addSubview(snapshotView)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            snapshotView.frame = container.convertRect(toVC.selectedCell.imageView.frame, fromView: toVC.selectedCell)
            fromVC.view.alpha = 0
            }) { (finish: Bool) -> Void in
                toVC.selectedCell.imageView.hidden = false
                snapshotView.removeFromSuperview()
                fromVC.avatarImageView.hidden = false
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}
