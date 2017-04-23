//
//  BaseViewController.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/27.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit
//  首页四个控制器的父类，作为未登录状态判断
class BaseViewController: UIViewController,NoLogViewDelegate {

    let isHadLoggin :Bool = false
    //  自定义导航栏
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 64))
    // 自定义导航条目  子类统一使用 navItem
    lazy var navItem  = UINavigationItem()
    
    lazy var nologvvv : NoLogView = NoLogView.shareNoLogView()

    override var title: String? {
        didSet{
            navItem.title = title
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
       
     }
    override func loadView() {
        isHadLoggin ?  super.loadView(): setNoLogView()
    }
    
    
}
extension  BaseViewController {

    func setUpNavBar(){
        // 添加导航条
        view.addSubview(navigationBar)
        // 将item设置给bar
        navigationBar.items = [navItem]
        
    }
    
}
extension  BaseViewController {
    
    func setNoLogView() {
        let aview=nologvvv
        aview.delegate=self
        view=aview
    }
    func registButtonWillClick() {
        print("zhuce")
    }
    func logginButtonWillClick() {
        print("denglu")
        let VC = LoginVC()
        
        navigationController?.pushViewController(VC, animated: true)
    }
    
    func setNavgationBarNoLogedItems(){
        //        UIBarButtonItem.titleLableWithText(title: "hhhhhh")
        
        navigationItem.leftBarButtonItem=UIBarButtonItem.init(title: "登录", style: .plain, target: self, action: #selector(registButtonWillClick))
        navigationItem.rightBarButtonItem=UIBarButtonItem.init(title: "注册", style: .plain, target: self, action: #selector(logginButtonWillClick))
    }
    
}

