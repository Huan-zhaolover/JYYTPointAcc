//
//  JYRefreshControl.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/30.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

class JYRefreshControl: UIControl {

    
    /// 刷新控件的俯视图，下拉刷新应用于UITableView／UICollectionView
    private weak var scrollView :UIScrollView?
    
    
    init(){
        super.init(frame: CGRect())
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        setupUI()
    }
    
    
    /// addSubview 会调用 willMove方法，
    /// 当添加到父视图的时候，newSuperview是父视图
    /// 当父视图被移除的时候， newSuperview 为nil
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview);
        
        guard let sv = newSuperview as? UIScrollView else {
            return
        }
        scrollView = sv
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
        
        
        
    }
    
    
    /// 所有KVO方法，会调用此方法
    ///
    /// - Parameters:
    ///   - keyPath: <#keyPath description#>
    ///   - object: <#object description#>
    ///   - change: <#change description#>
    ///   - context: <#context description#>
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let sv = scrollView else {
             return
        }
    
        
        let heigh = -(sv.contentOffset.y+sv.contentInset.top)
        
        self.frame = CGRect(x: 0, y: -heigh, width: sv.bounds.width, height: heigh)
        
        
    
    }
    
    
    func beginRefreshing(){
    
    }
    func endRefreshing(){
    
    }
    
}

extension JYRefreshControl {

    func setupUI(){
    
    }
}
