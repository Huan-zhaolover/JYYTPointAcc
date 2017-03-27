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
        addSelfChildViewController(childVC: HomeVC(), title: "首页", imageString: "home_tabbar_fp")
        addSelfChildViewController(childVC: BillListVC(), title: "账单", imageString: "home_tabbar_zd")
        addSelfChildViewController(childVC: StatementVC(), title: "报表", imageString: "home_tabbar_bb")
        addSelfChildViewController(childVC: MineVC(), title: "我的", imageString: "home_tabbar_hb")
        text1()
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
   private func text1()  {
        //  动态获取命名空间
        let nas = Bundle.main.infoDictionary! ["CFBundleExecutable"] as! String
        
        let cls:AnyClass? =  NSClassFromString(nas+".".appending("BillListVC"))
        let vcclas =  cls as! UIViewController.Type
        let vcccc = vcclas.init()
        print(vcccc)
        
        let path = Bundle.main.path(forResource: "home.plist", ofType: nil)
        if let filePath = path{
            do {
                let data = NSData(contentsOfFile: filePath)
                let diarry:Any = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
                
                for adic in diarry as! [[String:String]] {
                    print(adic)
                    
                }
                print(diarry)
                
            } catch   {
                print("读取本地数据出现错误！")
            }
        }

    }

}
