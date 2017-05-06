//
//  UserAccountViewModel.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/26.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserAccountViewModel {
    static let shareIntance : UserAccountViewModel = UserAccountViewModel()
    
    var userInfo = realm.objects(JYUserInfomation.self).first
    var isLogin : Bool {
        return userInfo != nil
    }
}
extension UserAccountViewModel {
    
    
    /// 登录接口
    ///
    /// - Parameters:
    ///   - mobile: 登录的时候穿手机号，自动登录不需要传
    ///   - password: 登录的时候传密码，自动登录不需要传
    ///   - isSuccess: 是否成功
    func loadUserInfo(mobile:String="",password:String="", isSuccess : @escaping (_ isSuccess : Bool)->()) {
        
        let amobile = mobile != "" ? mobile : userInfo?.mobile
        let apassword = password != "" ? NSString.md5StringWIthOrinalString(password) : userInfo?.password
     
        let prama : [String:Any] = ["mobile":amobile ?? "",
                                    "password":apassword ?? "",
                                    "devicesType":"1",
                                    ]
        ALamoNetworkTool.netWorkTools.tokenRequest(type: .GET, url: "app/loginByEncry.htm?", parameters: prama, needNetWorkTip: false) { (respon, error) in
            
            if  error != nil {
                JYPrint(error)
                isSuccess(false)
                return;
            }
            let json = JSON(respon!)
            if let dataDic = json["data"].dictionaryObject {
                
                let auser = JYUserInfomation.init(value: dataDic)
                self.userInfo = auser
                try! realm.write({
                    realm.add(auser, update: true)
                })
                isSuccess(true)
            }else{
                isSuccess(false)
                
            }
        }
    
    }
    

}
