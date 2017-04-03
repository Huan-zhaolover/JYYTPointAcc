//
//  WelcomeVC.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/3.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var messageLable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // lable的文字，需要网络请求，暂时写欢迎回来
    // 动画在viewWillApper 中显示
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        messageLable.text = "欢迎回来，您已经记账2220天"
        startLableAnimation()
        
        
    }
     private func startLableAnimation(){
        messageLable.transform  = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 3))
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: .curveEaseIn, animations: {
            self.messageLable.transform = CGAffineTransform.identity
        }) { (_) in
            // 去主页
            NotificationCenter.default.post(name: SwitchRootVCNotification, object: nil);
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
