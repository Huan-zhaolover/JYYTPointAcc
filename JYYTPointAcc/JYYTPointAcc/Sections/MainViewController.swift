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
        tabBar.tintColor=UIColor.clear
        addSelfChildViewController(childVC: BillListVC(), title: "账单", imageString: "home_tabbar_zd")
        addSelfChildViewController(childVC: StatementVC(), title: "报表", imageString: "home_tabbar_bb")
        addSelfChildViewController(childVC: InvoiceListVC(), title: "发票", imageString: "home_tabbar_fp")
        addSelfChildViewController(childVC: PartnerVC(), title: "伙伴", imageString: "home_tabbar_hb")

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
