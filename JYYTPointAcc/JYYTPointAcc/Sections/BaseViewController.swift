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
    lazy var nologvvv : NoLogView = NoLogView.shareNoLogView()

    override func loadView() {
        isHadLoggin ?  super.loadView(): setNoLogView()
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavgationBarItems()
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
    }
    
    func setNavgationBarItems(){
        navigationItem.leftBarButtonItem=UIBarButtonItem.init(title: "登录", style: .plain, target: self, action: #selector(registButtonWillClick))
        navigationItem.rightBarButtonItem=UIBarButtonItem.init(title: "注册", style: .plain, target: self, action: #selector(logginButtonWillClick))
    }
    
}
