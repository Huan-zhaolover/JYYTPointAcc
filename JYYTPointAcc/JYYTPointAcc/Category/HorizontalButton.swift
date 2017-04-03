//
//  HorizontalButton.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/1.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit
// 左titleLable  y右imageView
class HorizontalButton: UIButton {

    override func draw(_ rect: CGRect) {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
 
        titleLabel?.center = CGPoint(x: (titleLabel?.frame.size.width)!*0.5, y: frame.size.height * 0.5)
        titleLabel?.textAlignment = .center
        titleLabel?.sizeToFit()
        imageView?.center = CGPoint(x:  (titleLabel?.frame.size.width)! + (imageView?.frame.size.width)!*0.5, y: frame.size.height*0.5)
    }

}
