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
    /*
     @property (nonatomic,strong)NSString *person_id;    //用户id
     @property (nonatomic,strong)NSString *name;         //用户名称
     @property (nonatomic,strong)NSString *photo_path;   //头像路径
     @property (nonatomic,strong)NSString *mobile;       //手机号
     @property (nonatomic,strong)NSString *password;     //password
     @property (nonatomic,strong)NSString *gender;       //性别
     @property (nonatomic,strong)NSString *unit_name;    //企业名称
     @property (nonatomic,assign)BOOL     isLogin;       //判断是否为登录状态
     @property (nonatomic,strong)NSString *accountBookID;// 当前的账单ID
     
     @property BOOL  accountIsAdmin;
     @property NSData *headImageDate;
     
     //1.0
     @property NSString *accountBookName;
     // 1.0.3
     @property NSString *invite_code;
     // 1.2
     @property int accountIs_approva;  // 账本是否需要审批
     */
    dynamic var person_id = ""   //用户id
    dynamic var invite_code = ""   // 邀请码
    dynamic var name = ""       //用户名称
    dynamic var photo_path = "" //头像路径
    dynamic var mobile = ""     //手机号
    dynamic var password = ""  //password
    dynamic var encrPassword = ""  //加密password
    
    dynamic var gender = ""     //性别
    dynamic var unit_name = ""  //企业名称
    dynamic var isLogin = true    // 判断是否为登录状态
    dynamic var headImageDate = ""  // 图片imageData
    
    dynamic var currentBookID = ""   // 当前账本ID
    dynamic var currentBookName = ""  // 当前账本name
    dynamic var currentBookIsNeed_approva =  false  // 当前账本是否需要审批

 // Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
