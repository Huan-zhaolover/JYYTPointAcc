//
//  JYUserInfomation.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/25.
//  Copyright © 2017年 shjy. All rights reserved.
//

import Foundation
import RealmSwift

class JYUserInfomation: Object {
   
    dynamic var person_id = ""   //用户id
    dynamic var invite_code = ""   // 邀请码
    dynamic var mobile = ""     //手机号
    dynamic var password = ""       //password
    dynamic var encrPassword = ""  //加密password
    dynamic var name = ""       //用户名称
    dynamic var photo_path = "" //头像路径
    dynamic var appkey = ""         //登录返回的token

    dynamic var gender = ""     //性别
    dynamic var unit_name = ""  //企业名称
    dynamic var isLogin = true    // 判断是否为登录状态
    dynamic var headImageDate = ""  // 图片imageData
    
    dynamic var currentBookID = ""   // 当前账本ID
    dynamic var currentBookName = ""  // 当前账本name
    dynamic var currentBookIsNeed_approva =  false  // 当前账本是否需要审批

    override static func primaryKey() -> String? {
        return "person_id"
    }
}
