//
//  JYComon.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/20.
//  Copyright © 2017年 shjy. All rights reserved.
//

import Foundation
import UIKit
import YYModel

let JYAppUrl = "http://mapi.pointacc.com/"          //正式环境
//let JYAppUrl = "http://demo.shjysoft.com:3020/"    //测试环境
//let JYAppUrl = "http://10.0.3.147:8090/"          //张环境

let  APPSecreat = "922f1999d6fa3d13ff018e5e1d7cf507"

let AllViewColor  = UIColor.RGB(245, 245, 245)      //view背景色
let CellLineColor = UIColor.RGB(225, 225, 225)      //cell分割线颜色
let NavColor      = UIColor.RGB(253, 204, 14)       //导航栏颜色
let NavTitleColor = UIColor.RGB(149, 69, 20)        //导航栏 左右按钮字体颜色

let ShareSDKAppKey = "12755f26287aa"                //ShareSDK key
let APPID_VALUE = "578d8ea3"                        //讯飞语音



let BillNavTitleChange = "BillNavTitleChange"       //账单导航栏年份的改变
let BillRedBadge = "BillRedBadge"                   //首页账单小红点


let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String

let IOS_VERSION = Double(UIDevice.current.systemVersion)
let AppVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"]!

let ScreenW = UIScreen.main.bounds.width
let ScreenH = UIScreen.main.bounds.height

let APPDELEGATE = UIApplication.shared.delegate!
































    
    

 // 加载nib 文件
func LOLoadBundleNib(_ nibVC:UIViewController.Type) ->(UIViewController){
    return  nibVC.init(nibName: nil, bundle: nil)
}
// print
func JYPrint<T>(_ message : T, fileName : String = #file, lineNum : Int = #line,functionName:String = #function) {
    #if DEBUG
        // 处理fileName
        let file = (fileName as NSString).lastPathComponent
        print("------\(file):[\(lineNum)]\n[\(functionName)]\(message)")
    #endif
}

