//
//  VerticalButton.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/31.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

class VerticalButton: UIButton {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        titleLabel?.textAlignment = .center;
    }
 
    override func layoutSubviews() {
        super.layoutSubviews()

        imageView?.frame.origin.x=8;
        imageView?.frame.origin.y=0;
 
        imageView?.frame.size.width=frame.size.width-16;
        imageView?.frame.size.height=(imageView?.frame.size.width)!;
        
        titleLabel?.frame.origin.x=0;
        titleLabel?.frame.origin.y=(imageView?.frame.size.height)! + 8;
        titleLabel?.frame.size.width=frame.size.width;
        titleLabel?.frame.size.height=frame.size.height - (titleLabel?.frame.size.width)!;

    }

}
