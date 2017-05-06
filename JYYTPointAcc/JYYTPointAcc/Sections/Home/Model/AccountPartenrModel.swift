//
//  AccountPartenrModel.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/5/6.
//  Copyright © 2017年 shjy. All rights reserved.
//

import Foundation
import RealmSwift

class AccountPartenrModel: Object {
    
    dynamic var id = ""      // 主键
    dynamic var labels = ""           // 标签
    dynamic var partner_name = ""   // 伙伴名称
    dynamic var unit_name = ""      // 公司名称
    dynamic var mobile = ""          // 手机号
    dynamic var photo_path = ""      // 头像路径
   
    override static func primaryKey() -> String? {
        return "id"
    }
}
