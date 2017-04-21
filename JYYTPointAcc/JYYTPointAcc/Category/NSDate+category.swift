//
//  NSDate+category.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/1.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

extension Date {
    
    static func nowTime()->String{
        return Date.getTime(fomatter: "yyyy-MM-dd")
    }
    static func nowTimeDetail()->String{
        return Date.getTime(fomatter: "yyyyMMddHHmmss")
    }
    
    static func getTime(fomatter:String)->String{
        let date = NSDate()
        let afomatter =  DateFormatter()
        afomatter.dateFormat = fomatter
        return afomatter.string(from: date as Date)
    }
    // dateOne< dateTwo  orderedAscending 升序，>是降序
    static func compareDateString(dateOne:String,dateTwo:String) ->ComparisonResult{
        return Date.compareDateStringWithFomatter(fomatter: "yyyy-MM-dd", dateOne: dateOne, dateTwo: dateTwo);
    }
    static func compareDateStringWithFomatter(fomatter:String, dateOne:String,dateTwo:String) ->ComparisonResult{
        let afomatter =  DateFormatter()
        afomatter.dateFormat = fomatter
        var dt1 = Date();
        var dt2 = Date();
        
        dt1 = afomatter.date(from: dateOne)!
        dt2 = afomatter.date(from: dateTwo)!

        return dt1.compare(dt2 as Date)
    }
    
}
