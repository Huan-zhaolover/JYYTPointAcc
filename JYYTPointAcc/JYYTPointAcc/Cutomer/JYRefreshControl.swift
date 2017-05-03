//
//  JYRefreshControl.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/30.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

enum JYRefreshState {
    case Normal
    case Pulling
    case WillRefresh
}
let JYRefreshViewHeigh :CGFloat = 40

class JYRefreshControl: UIControl {

    
    /// 刷新控件的俯视图，下拉刷新应用于UITableView／UICollectionView
    private weak var scrollView :UIScrollView?
    lazy var refreshView = JYNomalRefreshView.refreshView()
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
    // 当本视图从父视图上移除的时候，所有的下拉刷线控件都是监听父视图的contentOffset
    override func removeFromSuperview() {
        superview?.removeObserver(self, forKeyPath: "contentOffset");
        super.removeFromSuperview()
    }
    
    
    /// 所有KVO方法，会调用此方法
    /// 通常只监听某一个对象的某几个属性，在不需要的时候，需要释放，
    //  通知中心，如果不释放什么也不会发生，会内存邂逅，出现注册多册的问题
    //  KVO 如果不释放，会崩溃
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let sv = scrollView else {
             return
        }
        
        let heigh = -(sv.contentOffset.y+sv.contentInset.top)
        
        self.frame = CGRect(x: 0, y: -heigh, width: sv.bounds.width, height: heigh)

        //判断临界点，只判断一次
        if sv.isDragging {
            if heigh > JYRefreshViewHeigh && (refreshView.refreshState == .Normal) {
                print("放手就刷新");
                refreshView.refreshState = .Pulling
            } else if heigh < JYRefreshViewHeigh && (refreshView.refreshState == .Pulling) {
            
                print("继续使劲拉")
                refreshView.refreshState = .Normal
            }
        }else{
        // 放手，判断是否超过临界点
            if refreshView.refreshState == .Pulling {
                 print("准备开始刷新")
                // 刷新之后将状态修改为nomad 之后才能继续响应刷新
                refreshView.refreshState = .WillRefresh
            }
        }
        
        
    
    }
    
    func beginRefreshing(){
    
    }
    func endRefreshing(){
    
    }
    
}

extension JYRefreshControl {

    func setupUI(){
        backgroundColor = UIColor.orange
        
        clipsToBounds = true
        addSubview(refreshView)
        refreshView.center = center
        
        refreshView.translatesAutoresizingMaskIntoConstraints = false;
        
        // 中心对齐
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0))
        // 距离底部10
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: -10))
        
    }
}
