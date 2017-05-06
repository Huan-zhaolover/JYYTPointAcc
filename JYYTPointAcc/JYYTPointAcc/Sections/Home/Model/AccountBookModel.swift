//
//  AccountBookModel.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/5/6.
//  Copyright © 2017年 shjy. All rights reserved.
//

import Foundation
import RealmSwift

class AccountBookModel: Object {
    dynamic var id = ""   //账本ID
    dynamic var short_name = ""   //账本name
    dynamic var photo_path = ""   // 账本背景图片，取本地图片
    dynamic var path = ""         // 图片name
    dynamic var name = ""         //账本name
    dynamic var partner_count = 0 //伙伴的count
    dynamic var templet_id = ""   //账本模版ID
    dynamic var templet_name = ""   //账本模版name
    dynamic var is_admin = true     //是不是拥有者
    dynamic var is_approval = false   //是否需要审批

 
    dynamic var booksStatis : AccStatisticsModel?  //账本统计数据
//    let partners = List<AccountPartenrModel>()      //账本中的伙伴
    dynamic var uniqueCode = ""   // 唯一标识
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
