//
//  AppDelegate.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/25.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
 
        NotificationCenter.default.addObserver(self, selector: #selector(changeRoot), name: SwitchRootVCNotification, object: nil)
        window=UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor=UIColor.white
        
  
        window?.rootViewController =  defaultContoller()

        window?.makeKeyAndVisible()
        
        AFNNetWorkTool.AFNTools.afnRequest(methodType: .GET, urlString: "http://www.baidu.com", parames: nil) { (rest, error) in
            guard let rest = rest else{
                print("\(error!)")

                return
            }
            print("\(rest)")
    
        }
        return true
    }
   
    
  
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

    func  defaultContoller()->UIViewController{
      
        //   1.检测用户是否登录
        let  isLog = true
        if isLog {
            // 已经登录之后，每次进入判断是不是最新版本，不是最新，显示欢迎回来界面
            if isNewVerson() {
                let New =  NewFeatureVC()
                New.imageArry = ["1","2","3","4"]
                return  New
            }else{
                return WelcomeVC()
            }
         }else{
            return MainViewController()
        }
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

