//
//  JYNomalRefreshView.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/5/2.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit


class JYNomalRefreshView: UIView {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var icomImageView: UIImageView!
    @IBOutlet weak var indictior: UIActivityIndicatorView!
    
    
    var refreshState:JYRefreshState = .Normal{
        didSet{
            switch refreshState {
            case .Normal:
                titleLable.text = "继续使劲拉---"
            case .Pulling:
                titleLable.text = "放手就刷新-----"
            case .WillRefresh:
                titleLable.text = "正在刷新中----"
        }
            
        }
    }
    class func refreshView()-> JYNomalRefreshView{
        let nib = UINib.init(nibName: "JYNomalRefreshView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil)[0] as! JYNomalRefreshView
    }
    
}
