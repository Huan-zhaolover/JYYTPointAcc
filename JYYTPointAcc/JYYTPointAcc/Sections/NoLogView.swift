//
//  NoLogView.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/27.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

class NoLogView: UIView {

    class func shareNoLogView() -> NoLogView {
       return Bundle.main.loadNibNamed("NoLogView", owner: nil, options: nil)?.first as! NoLogView
    }
    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var messageLable: UILabel!
    @IBOutlet weak var regisButton: UIButton!
    @IBOutlet weak var logginButton: UIButton!
    
 
    func setUpNologViewInfo(imageString:String,title:String){
 
        rotationView.isHidden=true
        iconImageView.image=UIImage(named: imageString)
        messageLable.text=title
    }
    func addRotationAnimation(){
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        
        animation.fromValue = 0
        animation.toValue = M_PI * 2
        animation.repeatCount=MAXFLOAT
        animation.isRemovedOnCompletion = false
        
        rotationView.layer.add(animation, forKey: "homeRotation")
    }
}
