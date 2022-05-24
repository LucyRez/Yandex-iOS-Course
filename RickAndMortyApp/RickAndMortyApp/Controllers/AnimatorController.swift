//
//  AnimatorController.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 24.05.2022.
//

import UIKit

class AnimatorController: NSObject, UIViewControllerAnimatedTransitioning{
    
    let presentationStartImage: UIImageView
    
    
    init(presentationImage: UIImageView){
        presentationStartImage = presentationImage
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        
        guard  let presentedVC = transitionContext.viewController(forKey: .to),
               let presentedView = transitionContext.view(forKey: .to) else{
                   transitionContext.completeTransition(false)
                   return
               }
        
        let finalFrame = transitionContext.finalFrame(for: presentedVC)
        let startImageFrame = presentationStartImage.convert(presentationStartImage.bounds, to: containerView)
        let startImageCenter = CGPoint(x: startImageFrame.midX, y: startImageFrame.midY)
        
        containerView.addSubview(presentedView)
        presentedView.center = startImageCenter
        presentedView.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            presentedView.transform = CGAffineTransform(scaleX: 1, y: 1)
            presentedView.frame = finalFrame
        }, completion: { (finished) in
            transitionContext.completeTransition(finished)
        })
        
        
    }
    
    
    
}
