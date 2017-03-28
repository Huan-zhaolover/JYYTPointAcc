//
//  HomePopOverAnimator.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/28.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

class HomePopOverAnimator: NSObject {
    var isPresented : Bool = false
    
}
// MARK:- 自定义转场代理的方法
extension HomePopOverAnimator : UIViewControllerTransitioningDelegate {
    // 告诉代理，谁是处理展示的VC
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?{
      let homePrentVC = HomeUIPresentationVC(presentedViewController: presented, presenting: presenting)
        return  homePrentVC
    }
    // 告诉代理，谁处理开始动画
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresented = true
        return self
    }
    // 告诉代理，谁处理结束动画
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresented = false
        return self
    }
}
// MARK:- 弹出和消失动画代理的方法
extension HomePopOverAnimator:UIViewControllerAnimatedTransitioning{
    // This is used for percent driven interactive transitions, as well as for
    // container controllers that have companion animations that might need to
    // synchronize with the main animation.
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        return 1
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning){

        if isPresented {
            animationForStartAnimation(ransitionContext: transitionContext)
        }else{
            animationForEndAnimation(ransitionContext: transitionContext)
        }
    }
    // 开始动画
    private func animationForStartAnimation(ransitionContext: UIViewControllerContextTransitioning){
      // 获取view，将view加到contenterView上，执行动画
        let containerView = ransitionContext.containerView
        let prentedView = ransitionContext.view(forKey: .to)
        containerView.addSubview(prentedView!)
        
        
        prentedView?.transform = CGAffineTransform.init(translationX: -containerView.bounds.size.width, y: 0)
        //        prentedView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        UIView.animate(withDuration: transitionDuration(using: ransitionContext), animations: {
           prentedView?.transform = CGAffineTransform.identity
        }) { (Bool) in
           ransitionContext.completeTransition(true)
        }
    }
    // 结束动画
    private func  animationForEndAnimation(ransitionContext: UIViewControllerContextTransitioning){
        // 获取view， 执行消失动画
        let containerView = ransitionContext.containerView
        let dismissView  = ransitionContext.view(forKey: .from)
        UIView.animate(withDuration: transitionDuration(using: ransitionContext), animations: {
            dismissView?.transform = CGAffineTransform.init(translationX: -containerView.bounds.size.width, y: 0)
            
            
        }) { (Bool) in
            dismissView?.removeFromSuperview()
            ransitionContext.completeTransition(true)
        }
    }
    
}


