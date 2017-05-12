//
//  CZEmotionManager.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/5/9.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

class CZEmotionManager {
    
    static let share = CZEmotionManager()
    
    // 单例如果调用了init方法，和share方法，得到的是不同的对象，
    //  init 用private 修饰，外部只能使用share 方法
    private init() {
        loadPackAges()
    }
    
    
    var packges :[[AccountBookModel]]{
        
        return[[AccountBookModel(), AccountBookModel()]]
    }
    
}
extension CZEmotionManager{
    
    func loadPackAges(){
       
        // 通过mainBundle，找到素材bundle，找到素材plist的path，plist转为数组
        guard let path  = Bundle.main.path(forResource: "HHEmotion.bundle", ofType: nil),
            let bundle  = Bundle(path: path) ,
            let plistpath = bundle.path(forResource: "emotion.plist", ofType: nil),
            let arry  = NSArray(contentsOfFile: plistpath) as? [[String:String]] else {
            return
            
        }
        print("\(arry)")
        
    }
    
    // OC 中过滤数组，使用谓词
    // swift 中，过滤使用filter， P是数组，判断数组中的模型的一个属性的值是不是相等
    func findEmotion(sting:String)->AccountBookModel?{
        for p in packges {
            
            // 方法1:
            let resurl =  p.filter({ (em) -> Bool in
                return em.name == sting
            })
            
            // 尾随闭包：
            let _ =  p.filter(){ (em) -> Bool in
                return em.name == sting
            }
            
            // 如果是尾随闭包只有一句，并且是返回，
            // 闭包格式可以省略，
            // 参数省略之后，可以使用$0,$1....以此替代原有的参数
            let _ =  p.filter() {
                return $0.name == sting
            }
            
            // return 也可以省略
            let _ =  p.filter() { $0.name == sting }
            
            
            
            if resurl.count == 1 {
                return resurl[0]
            }
        }
        return nil

    }
    
    /// 测试正则表达式
    func textRegurlar() {
        
        // 匹配中间带【】的字符，任何字符都行
        let orignalString = "hahaah[hsjfs]sjhfjgd[sdjg]"
        // 字符中 【】() 是正则表达式的关键字，如果参与匹配，需要转义
        let pattern = "\\[.*?\\]"
        
        guard let regular = try? NSRegularExpression(pattern: pattern, options: []) else {
            return;
        }
        // 匹配所有项
        let matches = regular.matches(in: orignalString, options: [], range: NSRange(location: 0, length: orignalString.characters.count))
        // for循环所有项，根据所有项所在的range，匹配出字符串
        for m in matches {
            let r  = m.rangeAt(0)
            let subStr = (orignalString as NSString).substring(with: r)
            
            print("\(subStr)")
            
        }
    }
}
