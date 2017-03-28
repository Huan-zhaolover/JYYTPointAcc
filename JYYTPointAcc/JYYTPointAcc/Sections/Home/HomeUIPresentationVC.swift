//
//  HomeUIPresentationVC.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/28.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

class HomeUIPresentationVC: UIPresentationController {
    // 懒加载控件
    lazy var coverBGView :UIButton = UIButton()
    // 重写layoutsubviews 设置弹出视图的大小
    override func containerViewWillLayoutSubviews(){
        super.containerViewWillLayoutSubviews()
        //
        presentedView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width*0.6, height: UIScreen.main.bounds.size.height)
        
        setCoverbgViews()
    }
}
extension HomeUIPresentationVC {
    
    func setCoverbgViews(){
        // 设置大小，插入到contenderView的最底层
        coverBGView.titleLabel?.text=""
        coverBGView.frame  = containerView!.bounds
        coverBGView.backgroundColor = UIColor.init(white: 0.8, alpha: 0.2)
        coverBGView.addTarget(self, action: #selector(tapCoverBgView), for: .touchUpInside)
        containerView?.insertSubview(coverBGView, at: 0)
    }
}

extension HomeUIPresentationVC {
   @objc func tapCoverBgView(tap:UITapGestureRecognizer){
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}

