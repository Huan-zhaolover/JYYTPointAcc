//
//  VerticalButton.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/31.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

class VerticalButton: UIButton {
    
    override func draw(_ rect: CGRect) {
 
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        imageView?.center = CGPoint(x: frame.size.width*0.5, y: (imageView?.image?.size.height)!*0.5)
        titleLabel?.center = CGPoint(x: frame.size.width*0.5, y: frame.size.height - (titleLabel?.frame.size.height)!*0.7 )
        titleLabel?.textAlignment = .center
        titleLabel?.sizeToFit()
    }

}
