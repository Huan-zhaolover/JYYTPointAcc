//
//  JYNavigationController.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/22.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

class JYNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 隐藏默认的navigationBar，在BaseViewController中自定义navigationBar和item
        navigationBar.isHidden = true
        // Do any additional setup after loading the view
    }
    
    // 重写push方法，initRootviewcontroller 的时候就压栈，调用此方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 当不是栈底控制器的时候，push隐藏tabbar
        // 判断控制器的类型
        if let vc = viewController as? BaseViewController {
            var title = "返回"
            if childViewControllers.count > 0 {
        
                title = childViewControllers.first?.title ?? "返回"
                viewController.hidesBottomBarWhenPushed = true
            }
            vc.navItem.leftBarButtonItem = UIBarButtonItem.itemWithTitle(itemType: .Left, titleStr: title, target: self, action: #selector(goBack))
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc private func  goBack(){
        popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
