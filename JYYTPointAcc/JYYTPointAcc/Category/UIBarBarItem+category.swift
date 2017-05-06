//
//  UIBarBarItem+category.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/27.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

enum BarItemType {
    case Right
    case Left
}

extension UIBarButtonItem {
    /// 设置主题颜色
    class func setTheBarTintColor(color:UIColor){
        UINavigationBar.appearance().tintColor=color
    }
    /**  返回titleLable
     */
    class func titleLableWithText(title:String)->UILabel{
        let lable = UILabel()
        lable.clipsToBounds = true
        lable.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width*0.5, height: 30)
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.textColor = UIColor.init(red: 51, green: 51, blue: 51, alpha: 1)
        lable.text = title
        return lable
    }
    /// 自定义button，图片和高亮图片
    class func itemWithImage(imageStr:String,highleImageStr:String?,target:Any?,action:Selector) -> UIBarButtonItem{
    
        let btn = UIButton(frame: CGRect.init(x: 0, y: 0, width: 40, height: 35))
        btn.titleLabel?.text=""
        btn.setImage(UIImage.init(named: imageStr), for: .normal)
        if let highstr =  highleImageStr{
            btn.setImage(UIImage.init(named: highstr), for: .highlighted)
        }
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        return UIBarButtonItem.init(customView: btn)
    }
    
    
    /// 自定义item title按钮
    ///
    /// - Parameters:
    ///   - titleStr: title
    ///   - target:  target
    ///   - fontsize:   字体，默认16号
    ///   - action: action
    static func itemWithTitle(itemType:BarItemType, titleStr:String,fontsize:CGFloat = 16.0, target:Any?,action:Selector) -> UIBarButtonItem{
        
        let font = UIFont.systemFont(ofSize: fontsize)
        let width = titleStr.sizeWithFont(fontsize: fontsize)
        
        let btn = UIButton(frame: CGRect.init(x: 0, y: 0, width: width.width, height: 35))
        btn.setTitle(titleStr, for: .normal)
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.titleLabel?.font = font
        btn.titleLabel?.textAlignment = (itemType == .Right) ? .right:.left
        btn.setTitleColor(UIColor.RGB(149, 69, 20), for: .normal)

        btn.setTitleColor(UIColor.init(red: 51, green: 51, blue: 51, alpha: 1), for: .highlighted)
        btn.sizeToFit()
        return UIBarButtonItem.init(customView: btn)
    }
    
}
