//
//  NSDate+category.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/1.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

extension NSDate {
    
    class func nowTime()->String{
        return NSDate.getTime(fomatter: "yyyy-MM-dd")
    }
    
    class func getTime(fomatter:String)->String{
        let date = NSDate()
        let afomatter =  DateFormatter()
        afomatter.dateFormat = fomatter
        return afomatter.string(from: date as Date)
    }
    // dateOne< dateTwo  orderedAscending 升序，>是降序
    class func compareDateString(dateOne:String,dateTwo:String) ->ComparisonResult{
        return NSDate.compareDateStringWithFomatter(fomatter: "yyyy-MM-dd", dateOne: dateOne, dateTwo: dateTwo);
    }
    class func compareDateStringWithFomatter(fomatter:String, dateOne:String,dateTwo:String) ->ComparisonResult{
        let afomatter =  DateFormatter()
        afomatter.dateFormat = fomatter
        var dt1 = NSDate();
        var dt2 = NSDate();
        
        dt1 = afomatter.date(from: dateOne)! as NSDate
        dt2 = afomatter.date(from: dateTwo)! as NSDate

        return dt1.compare(dt2 as Date)
    }
    
}
