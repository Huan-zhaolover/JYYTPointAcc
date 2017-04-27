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
    
    let isHadLoggin :Bool = UserAccountViewModel.shareIntance.isLogin
    
    lazy var nologvvv : NoLogView = NoLogView.shareNoLogView()

    //  自定义导航栏
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 64))
    // 自定义导航条目  子类统一使用 navItem
    lazy var navItem  = UINavigationItem()
    //  基类的表格tableView
    var tableView :UITableView?
    var refreshControl: UIRefreshControl?
    // 定义变量区分上拉，下拉刷新
    var isPullup = false
    

    override var title: String? {
        didSet{
            navItem.title = title
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        loadData()
       
     }
   // 加载数据，具体实现由子类实现
    func loadData(){
        refreshControl?.endRefreshing()
        
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
        isHadLoggin ?  setTableView(): setNoLogView()
        
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
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.lightGray];
    
    }
    
    /// 设置表格视图
    private func setTableView(){
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        //设置数据源和代理，子类直接使用方法
        tableView?.delegate = self
        tableView?.dataSource = self
    
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height,
                                               left: 0,
                                               bottom: tabBarController?.tabBar.bounds.height ?? 49,
                                               right: 0)
        
         refreshControl = UIRefreshControl()
         tableView?.addSubview(refreshControl!)
         refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    /// 设置访客视图
    func setNoLogView() {
        let aview=nologvvv
        aview.delegate=self
        view.insertSubview(aview, belowSubview: navigationBar)
    }
}

// MARK: - ---------------tableView 的代理和数据源方法
extension  BaseViewController:UITableViewDataSource,UITableViewDelegate {
    
    // 基类只是准备方法，子类负责实现，return 只是为了不报错
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         return UITableViewCell()
    }
    // 在显示最后一行的时候下拉刷新
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        let section = tableView.numberOfSections - 1
        if row < 0 || section < 0 {
            return
        }
        let arow = tableView.numberOfRows(inSection: section)
   
        if row == (arow-1) && !isPullup {
             JYPrint("上拉刷新")
            isPullup = true
            loadData()
            
        }
    }
}
// MARK: - ---------------登录注册的代理
extension  BaseViewController:NoLogViewDelegate {
    func registButtonWillClick() {
        print("zhuce")
        NotificationCenter.default.post(name: NotificationNameGoLogin, object: nil);
    }
    func logginButtonWillClick() {
        print("denglu")
        NotificationCenter.default.post(name: NotificationNameGoLogin, object: nil);
    }
    func setNavgationBarNoLogedItems(){
        navItem.leftBarButtonItem=UIBarButtonItem.init(title: "登录", style: .plain, target: self, action: #selector(registButtonWillClick))
        navItem.rightBarButtonItem=UIBarButtonItem.init(title: "注册", style: .plain, target: self, action: #selector(logginButtonWillClick))
    }
}

// extension不能写属性，不能重写父类方法，extension 是对的类的扩展
