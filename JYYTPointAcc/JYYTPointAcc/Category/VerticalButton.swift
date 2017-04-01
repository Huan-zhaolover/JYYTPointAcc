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

        imageView?.center = CGPoint(x: frame.size.width*0.5, y: (imageView?.image?.size.height)!*0.5)
        titleLabel?.center = CGPoint(x: frame.size.width*0.5, y: frame.size.height - (titleLabel?.frame.size.height)!*0.7 )
        titleLabel?.textAlignment = .center
        titleLabel?.sizeToFit()
//        imageView?.frame = CGRect(x: 8, y: 0, width: (imageView?.image?.size.width)!, height: (imageView?.image?.size.height)!)
//        titleLabel?.frame = CGRect(x: 0, y: (imageView?.frame.size.height)! + 8, width: frame.size.width, height: frame.size.height - (imageView?.frame.size.height)!)

//        titleLabel?.frame.origin.x=0;
//        titleLabel?.frame.origin.y=(imageView?.frame.size.height)! + 8;
//        titleLabel?.frame.size.width=frame.size.width;
//        titleLabel?.frame.size.height=frame.size.height - (titleLabel?.frame.size.width)!;
//        imageView?.frame.origin.x=8;
//        imageView?.frame.origin.y=0;
//
//        imageView?.frame.size.width=frame.size.width-16;
//        imageView?.frame.size.height=(imageView?.frame.size.width)!;
    }

}
