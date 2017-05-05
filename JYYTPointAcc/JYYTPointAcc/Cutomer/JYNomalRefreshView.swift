//
//  JYNomalRefreshView.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/5/2.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit


class JYNomalRefreshView: UIView {

    @IBOutlet weak var titleLable: UILabel?
    @IBOutlet weak var icomImageView: UIImageView?
    @IBOutlet weak var indictior: UIActivityIndicatorView?
    var parentViewHigh: CGFloat  = 0 
    /*
     ios  中旋转动画默认是
     1.顺时针的旋转，
     2.就近原则
      实现同方向旋转，减少一个极小的值
     如果旋转360，使用CABaseAnimation动画 
     */
    var refreshState:JYRefreshState = .Normal{
        didSet{
            switch refreshState {
            case .Normal:
                icomImageView?.isHidden = false
                indictior?.stopAnimating()
                
                titleLable?.text = "继续使劲拉---"
                UIView.animate(withDuration: 0.25, animations: { 
                    self.icomImageView?.transform = CGAffineTransform.identity
                })
                
            case .Pulling:
                titleLable?.text = "放手就刷新-----"
                UIView.animate(withDuration: 0.25, animations: { 
                    self.icomImageView?.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi-0.00001))
                })
                
            case .WillRefresh:
                titleLable?.text = "正在刷新中----"
                icomImageView?.isHidden = true
                indictior?.startAnimating()
                
        }
            
        }
    }
    class func refreshView()-> JYNomalRefreshView{
        // JYNomalRefreshView  JYNomalImageRefreshView  JYAnimationRefreshView
        let nib = UINib.init(nibName: "JYNomalRefreshView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil)[0] as! JYNomalRefreshView
    }
    
}
