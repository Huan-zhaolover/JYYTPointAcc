//
//  MainViewController.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/26.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor=UIColor.orange
        addSelfChildViewController(childVC: BillListVC(), title: "账单", imageString: "home_tabbar_zd")
        addSelfChildViewController(childVC: StatementVC(), title: "报表", imageString: "home_tabbar_bb")
        addSelfChildViewController(childVC: InvoiceListVC(), title: "发票", imageString: "home_tabbar_fp")
        addSelfChildViewController(childVC: PartnerVC(), title: "伙伴", imageString: "home_tabbar_hb")

         //  动态获取命名空间
        let nas = Bundle.main.infoDictionary! ["CFBundleExecutable"] as! String
        
        let cls:AnyClass? =  NSClassFromString(nas+".".appending("BillListVC"))
        let vcclas =  cls as! UIViewController.Type
        let vcccc = vcclas.init()
        print(vcccc)
        
        // Do any additional setup after loading the view.
    }
    private func addSelfChildViewController(childVC: UIViewController,title:String,imageString:String) {
        
        childVC.tabBarItem.image=UIImage(named: imageString)
        childVC.tabBarItem.selectedImage=UIImage(named: imageString.appending("_h"))
        childVC.tabBarItem.title=title
        childVC.title=title;
        
        let nav = UINavigationController(rootViewController: childVC)
        addChildViewController(nav)
    }

}
