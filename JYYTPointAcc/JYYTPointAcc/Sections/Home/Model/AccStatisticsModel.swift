//
//  AccStatisticsModel.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/5/6.
//  Copyright © 2017年 shjy. All rights reserved.
//

import Foundation
import RealmSwift

class AccStatisticsModel: Object {
    dynamic var books_id = ""   // 账本ID，根据账本ID获取统计列表
    dynamic var updateTime = ""         //  更新统计表的时间，刷新统计表今日之处，今日收入
    dynamic var payable =       0.00        // 应付款
    dynamic var receivable =    0.00        // 应收款
    dynamic var monthIncome =   0.00        // 本月收入
    dynamic var monthSpending = 0.00        // 本月支出
    dynamic var todaySpenCount = 0     // 今日支出数目
    dynamic var todaySpenAmount = 0.00    // 今日支出金额
    dynamic var todayIncoCount = 0     // 今日收入数目
    dynamic var todayIncoAmount = 0.00    // 今日收入金额
   
    dynamic var year = 2017               // 年份
    dynamic var yearSpenTotal = 0.00      // 年度支出总额
    dynamic var yearIncoTotal = 0.00      // 年度收入总额
  
    override static func primaryKey() -> String? {
        return "books_id"
    }
    
}
