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
        
        tabBar.tintColor=NavColor
//        UINavigationBar.appearance().tintColor=UIColor.orange
        
        addSelfChildViewController(childVC: HomeVC(), title: "首页", imageString: "home_tabbar_fp")
        addSelfChildViewController(childVC: BillListVC(), title: "账单", imageString: "home_tabbar_zd")
        addSelfChildViewController(childVC: StatementVC(), title: "报表", imageString: "home_tabbar_bb")
        addSelfChildViewController(childVC: MineVC(), title: "我的", imageString: "home_tabbar_hb")

        NotificationCenter.default.addObserver(self, selector: #selector(gotoLogin), name: NotificationNameGoLogin, object: nil)
    }
    override func loadView() {
         super.loadView()
            setUpUI()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
// 设置新特性界面，欢迎界面
extension MainViewController{
    func  setUpUI(){
        //  未登录直接进去，不需要引导页，欢迎界面
        
        if UserAccountViewModel.shareIntance.isLogin {
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

extension MainViewController :UITabBarControllerDelegate{

    func addSelfChildViewController(childVC: UIViewController,title:String,imageString:String) {
        childVC.tabBarItem.image=UIImage(named: imageString)
        childVC.tabBarItem.selectedImage=UIImage(named: imageString.appending("_h"))
        childVC.tabBarItem.title=title
        childVC.title=title;
        
        
        // 设置tabbar 标题的大小，颜色 大小默认是12号字体
        childVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:NavTitleColor], for: .normal)
        childVC.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 13)], for: .normal)
        addChildViewController(childVC)
    }
    //  加载登录界面
    @objc func gotoLogin(noti:Notification){
        // hadLog
        let logVC = JYLoadBundleNib(LoginVC.self)
        let nav = JYNavigationController(rootViewController: logVC)
        present(nav, animated: true, completion: nil)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        //在此间实现点击tabbar 刷新数据，清除角标
        // 获取vc  在数组中的索引
        // 判断当前的选择是首页，同时indx 是首页，重复点击首页的按钮
        //  是首页，滑动首页之后再刷新数据
        // 增加延迟，是控制滑到顶部再刷新数据
        let index = childViewControllers.index(of: viewController)
        if selectedIndex == 0 && selectedIndex == index{
            let nav  = childViewControllers[0] as! UINavigationController
            let vc = nav.childViewControllers[0] as! HomeVC
            vc.tableView?.setContentOffset(CGPoint(x: 0, y: -64), animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1 , execute: {
                vc.loadData()
            })
            vc.tabBarItem.badgeValue = nil
            UIApplication.shared.applicationIconBadgeNumber = 0
        
        }
        
        return true;
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
