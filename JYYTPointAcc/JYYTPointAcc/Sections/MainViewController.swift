//
//  MainViewController.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/26.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    let  loggOn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        tabBar.tintColor=UIColor.orange
        UINavigationBar.appearance().tintColor=UIColor.orange
        
        addSelfChildViewController(childVC: HomeVC(), title: "首页", imageString: "home_tabbar_fp")
        addSelfChildViewController(childVC: BillListVC(), title: "账单", imageString: "home_tabbar_zd")
        addSelfChildViewController(childVC: StatementVC(), title: "报表", imageString: "home_tabbar_bb")
        addSelfChildViewController(childVC: MineVC(), title: "我的", imageString: "home_tabbar_hb")

    }
}



// 设置新特性界面，欢迎界面
extension MainViewController{
    func  setUpUI(){
        //  未登录直接进去，不需要引导页，欢迎界面
        if !UserAccountViewModel.shareIntance.isLogin {
            return
        }
        if isNewVerson() {
            // 是新版本，加载引导页
            let NewVC =  NewFeatureVC(imageStrArry: ["1","2","3","4"])
            view .addSubview(NewVC)
        }else{
            // 欢迎界面
            let aview =   WelcomeView.loadWelcomeView()
            aview.frame = CGRect(x: 0, y: 0, width: ScreenW, height: ScreenH)
            view .addSubview(aview)
        }
    }
}
extension MainViewController{
    func isNewVerson()->(Bool) {
        let localVerion = UserDefaults.standard.value(forKey: UserDefaultAppVersionKey) as? String
        
        // 如果 localVerionString 为nil,return false，
        // 如果存储的versionString == 当前的appversion
        // guard 不满足条件才走else 中
        guard let localVerionString = localVerion, AppVersion != localVerionString else{
            return false
        }
        UserDefaults.standard.setValue(AppVersion, forKey: UserDefaultAppVersionKey)
        return true
    }
}

extension MainViewController{

    func addSelfChildViewController(childVC: UIViewController,title:String,imageString:String) {
        childVC.tabBarItem.image=UIImage(named: imageString)
        childVC.tabBarItem.selectedImage=UIImage(named: imageString.appending("_h"))
        childVC.tabBarItem.title=title
        childVC.title=title;
        
        
        // 设置tabbar 标题的大小，颜色 大小默认是12号字体
        childVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orange], for: .normal)
        childVC.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 13)], for: .normal)
        
        let nav = JYNavigationController(rootViewController: childVC)
        addChildViewController(nav)
    }
    //  动态获取命名空间
    private func text1()  {
        
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
