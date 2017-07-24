//
//  CZEmotionTipView.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/6/23.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit
// 点击表情，弹出的表情提示
class CZEmotionTipView: UIImageView {
   
    init(){
        let image = UIImage(named: "ceshi")
        super.init(image: image)
        layer.anchorPoint = CGPoint(x: 0.5, y: 1.2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
