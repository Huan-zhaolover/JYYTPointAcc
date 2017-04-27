//
//  WelcomeView.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/27.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

class WelcomeView: UIView {

    @IBOutlet weak var welcomeIconView: UIImageView!
    @IBOutlet weak var weclomeLable: UILabel!
   
    static func loadWelcomeView()-> WelcomeView{
    
        let aview = Bundle.main.loadNibNamed("WelcomeView", owner: nil, options: nil)?.last as? WelcomeView
        return aview!
    }
    override func awakeFromNib() {
         super.awakeFromNib()
            setUpUI()
    }
    func setUpUI(){
        backgroundColor = UIColor.red
        weclomeLable.text = "欢迎回来，您已经记账2220天"
        startLableAnimation()

    }
    private func startLableAnimation(){
        
        weclomeLable.transform  = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 3))
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: .curveEaseIn, animations: {
            self.weclomeLable.transform = CGAffineTransform.identity
        }) { (_) in
            // 去主页
            self.removeFromSuperview()
//            NotificationCenter.default.post(name: SwitchRootVCNotification, object: nil);
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
