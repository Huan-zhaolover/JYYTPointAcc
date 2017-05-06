//
//  BaseViewController.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/27.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit
//  首页四个控制器的父类，作为未登录状态判断
// 设置navBar, 设置tableView，封装上拉下拉刷新

class BaseViewController: UIViewController {
    //  自定义导航栏
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 64))
    // 自定义导航条目  子类统一使用 navItem
    lazy var navItem  = UINavigationItem()
    override var title: String? {
        didSet{
            navItem.title = title
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AllViewColor
        setUpUI()
     }
}

// MARK: - ---------------设置子视图
extension  BaseViewController {

    func setUpUI(){
        // 设置所有子视图的背景色
        view.backgroundColor = UIColor.white
        // 取消自动缩进，如果隐藏了导航条，会缩进20
        automaticallyAdjustsScrollViewInsets = false
        setNavbar()
        
    }
     /// 设置导航条
    private func setNavbar(){
        // 添加导航条
        view.addSubview(navigationBar)
        // 将item设置给bar
        navigationBar.items = [navItem]
        //设置navbar 的渲染染色
        navigationBar.barTintColor = NavColor
        //设置navbar 的字体颜色
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : NavTitleColor];
    }
}

// extension不能写属性，不能重写父类方法，extension 是对的类的扩展
