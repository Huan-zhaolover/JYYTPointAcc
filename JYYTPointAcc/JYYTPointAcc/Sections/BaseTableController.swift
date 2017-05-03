//
//  BaseTableController.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/27.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

class BaseTableController: BaseViewController {
    
    var isHadLoggin :Bool = UserAccountViewModel.shareIntance.isLogin
    lazy var nologvvv : NoLogView = NoLogView.shareNoLogView()
    //  基类的表格tableView
    var tableView :UITableView?
    
    var refreshControl: JYRefreshControl?
    // 定义变量区分上拉，下拉刷新
    var isPullup = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeUI), name: NotificationNameHadLoged, object: nil)

        // Do any additional setup after loading the view.
    }
    // 加载数据，具体实现由子类实现
    func loadData(){
        refreshControl?.endRefreshing()
    }
    override func setUpUI(){
        super.setUpUI()
        // 设置所有子视图的背景色
        view.backgroundColor = UIColor.white
        // 取消自动缩进，如果隐藏了导航条，会缩进20
        automaticallyAdjustsScrollViewInsets = false
         isHadLoggin ?  setTableView(): setNoLogView()
    }
    
    //  加载登录界面
    @objc func changeUI(noti:Notification){
        // hadLog
        isHadLoggin = UserAccountViewModel.shareIntance.isLogin
        guard let notti = noti.object, notti as! String == "hadLog" else {
            return
        }
        setUpUI()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension BaseTableController{
    /// 设置表格视图
    func setTableView(){
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        //设置数据源和代理，子类直接使用方法
        tableView?.delegate = self
        tableView?.dataSource = self
        
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height,
                                               left: 0,
                                               bottom: tabBarController?.tabBar.bounds.height ?? 49,
                                               right: 0)
        
        refreshControl = JYRefreshControl()
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
extension  BaseTableController:UITableViewDataSource,UITableViewDelegate {
    
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
extension  BaseTableController:NoLogViewDelegate {
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

