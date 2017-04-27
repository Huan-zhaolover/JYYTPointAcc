//
//  HomeVC.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/27.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit
private let cellid = "cellID"  //  定义全局常量，使用Private 修饰
class HomeVC: BaseTableController{

    // private
     lazy var homeAnimatir : HomePopOverAnimator = HomePopOverAnimator()
    
    var  count  = 21
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let user = realm.objects(JYUserInfomation.self).first
    
        if user==nil {
            nologvvv.addRotationAnimation()
        }
        
    }
    // 重写父类调用数据
    override func loadData() {
        // 模拟dispatchAfter 
        DispatchQueue.main.asyncAfter(wallDeadline: DispatchWallTime.now() + 2) {
            JYPrint("延迟加载")
            if self.isPullup {
                // 上拉刷新，加载数据后面
            }else {
                // 下拉刷新，拼接数据在前面
            }
            self.count += 10
            // 停止刷新，恢复刷新状态，刷新表格数据
            self.refreshControl?.endRefreshing()
            self.isPullup = false
            self.tableView?.reloadData()
            
        }
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) { 
//            JYPrint("延迟加载")
//            if self.isPullup {
//            // 上拉刷新，加载数据后面
//            }else {
//                // 下拉刷新，拼接数据在前面
//            }
//            
//            // 停止刷新，恢复刷新状态，刷新表格数据
//            self.refreshControl?.endRefreshing()
//            self.isPullup = false
//            self.tableView?.reloadData()
//            
//        }
        
    }
}
extension HomeVC {

    override func setUpUI() {
        super.setUpUI()
        setHomeNavBars()
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
        
        
    }
    
    
}
extension HomeVC {
    //MARK: ---------------设置NavBar
    func  setHomeNavBars(){
        if isHadLoggin {
            
            navItem.leftBarButtonItem =  UIBarButtonItem(titleStr: "账本", target: self, action: #selector(changeAccoountBook))
            navItem.rightBarButtonItem = UIBarButtonItem(title: "消息", style: .plain, target: self, action: #selector(messageList))
        }else{
            setNavgationBarNoLogedItems()
        }
    }
    //MARK: ---------------设置NavBar 的点击
    /// 切换账本
   @objc func changeAccoountBook(){
        let vc =  LeftChoseAccountBookVC()
        vc.modalPresentationStyle = .custom
    
        vc.transitioningDelegate = homeAnimatir
        
        present(vc, animated: true, completion:nil)
    }
    /// 查看消息
    @objc func messageList(){
        let  vc  = QRScanVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: cellid)
        
        cell?.textLabel?.text = "\(indexPath.section)+\(indexPath.row)"
        
        return cell!
    }
    
    
    
}



