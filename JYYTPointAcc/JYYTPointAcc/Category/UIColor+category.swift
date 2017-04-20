//
//  UIColor+category.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/1.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

extension UIColor{
    class func RGB(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ a:CGFloat = 1)->UIColor{
        return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
        
    }
    
    
}
