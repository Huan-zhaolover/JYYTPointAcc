//
//  NoLogView.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/27.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

protocol  NoLogViewDelegate :NSObjectProtocol{
    func registButtonWillClick()
    func logginButtonWillClick()
}

class NoLogView: UIView {

    class func shareNoLogView() -> NoLogView {
       return Bundle.main.loadNibNamed("NoLogView", owner: nil, options: nil)?.first as! NoLogView
    }
    weak var delegate:NoLogViewDelegate?
    
    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var messageLable: UILabel!
    @IBOutlet weak var regisButton: UIButton!
    @IBOutlet weak var logginButton: UIButton!
    
    // 根据控制器的不同，设置未登录页界面的图片和文字
    func setUpNologViewInfo(imageString:String,title:String){
 
        rotationView.isHidden=true
        iconImageView.image=UIImage(named: imageString)
        messageLable.text=title
        
    }
     //  MARK: 设置首页转轮动画
    func addRotationAnimation(){
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.repeatCount=MAXFLOAT
        animation.isRemovedOnCompletion = false
        animation.duration = 10   // 结束一次动画的时常
        
        rotationView.layer.add(animation, forKey: "homeRotation")
    }
 
    @IBAction func registButtonClick(_ sender: Any) {
        delegate?.registButtonWillClick()
    }
    @IBAction func logginButtonClick(_ sender: Any) {
        delegate?.logginButtonWillClick()
    }
    
}
