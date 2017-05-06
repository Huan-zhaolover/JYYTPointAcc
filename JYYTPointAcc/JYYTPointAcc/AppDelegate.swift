//
//  AppDelegate.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/25.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

import Alamofire

import RealmSwift
import SwiftyJSON
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isHaveNet:Bool = true
    let NetworkListener = NetworkReachabilityManager(host: "www.baidu.com")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        realm = setDatamigration()
        JYPrint(realm.configuration.fileURL)   // realm 数据库路径

        window=UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor=UIColor.white
        window?.rootViewController =  defaultContoller()
        window?.makeKeyAndVisible()
        
        startListenNetwork()
        
        autoLog()  // 等其他登录之后再登录，登录之后token切换
        return true
    }
       deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
//MARK: 测试
extension AppDelegate {
    // 自动登录
    func autoLog(){
       let amodel =  UserAccountViewModel.shareIntance
        // 如果登录过之后自动登录
        if amodel.isLogin {
            amodel.loadUserInfo { (isSueccsss) in
                if isSueccsss {
                    
                    JYPrint(amodel.userInfo)
                }
            }
             return
        }else{
            // 测试登录
            amodel.loadUserInfo(mobile: "111111111", password: "111111") { (isSueccsss) in
                
                if isSueccsss {
                    JYPrint(amodel.userInfo)
                }
            }
        }
    }
}
//MARK: 界面切换
extension  AppDelegate{
    func  defaultContoller()->UIViewController{
        return MainViewController()
         // FIXME: 引导页，欢迎界面，在main里面设置。
    }
    
    func changeRoot(noti:NSNotification){
        window?.rootViewController=MainViewController()
    }
    
    func isNewVerson()->Bool{
        let versonNow = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        
        let sanboxVerson = UserDefaults.standard.object(forKey: "CFBundleShortVersionString") as? String ?? ""
        // 2.0    1.0   降序
        if versonNow.compare(sanboxVerson) == .orderedDescending{
            
            UserDefaults.standard.setValue(versonNow, forKey: "CFBundleShortVersionString")
            UserDefaults.standard.synchronize()
            return true
        }
        return false
    }
}
//MARK: applegate 的代理
extension  AppDelegate{
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

// MARK: - 网络监测
extension  AppDelegate{
    func startListenNetwork(){
        NetworkListener?.listener = { reachabilityStatus in
            
            switch reachabilityStatus {
            case .notReachable:
                self.isHaveNet = false
                JYPrint("当前无连接")
            case .unknown:
                JYPrint("未知连接")
            case .reachable:
                self.isHaveNet = true
                    JYPrint("连接可用")
                    fallthrough      // 穿透
            case .reachable(.wwan):
                self.isHaveNet = true
                JYPrint("WWAN连接")
            case .reachable(.ethernetOrWiFi):
                self.isHaveNet = true
                JYPrint("WiFi连接")
            }
        }
        
        NetworkListener?.startListening()
        
    }
}
