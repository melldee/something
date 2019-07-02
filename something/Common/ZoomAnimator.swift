//
//  ZoomAnimator.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import UIKit

class ZoomAnimator: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    var initialFrame: CGRect = .zero
    
    // MARK: UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    // MARK: UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
              let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        
        let containerView = transitionContext.containerView
        isPresenting = !isPresenting
        
        if isPresenting {
            guard let toView = toViewController.view else { return }
            
            containerView.addSubview(toView)
            toView.frame = initialFrame
            toView.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                toView.frame = containerView.frame
                toView.layoutIfNeeded()
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        } else {
            guard let fromView = fromViewController.view else { return }
            
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                fromView.frame = self.initialFrame
                fromView.layoutIfNeeded()
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        }
    }
    
    private var isPresenting: Bool = false
}
