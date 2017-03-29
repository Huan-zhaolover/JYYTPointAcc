//
//  QRScanVC.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/29.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

class QRScanVC: UIViewController,UITabBarDelegate{
    @IBOutlet var customerTabBar: [UITabBar]!
    // 点击二维码，条形码进行高度切换
    @IBOutlet weak var contenerViewH: NSLayoutConstraint!
    // 冲进破 聚顶部的高度，从-contenerViewH -> 到0， 
    @IBOutlet weak var imageViewToTop: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(closeQRVC))
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "相册", style: .plain, target: self, action: #selector(choseQRImagePhete))
        
     }
}
extension QRScanVC{
    func closeQRVC(){
        print("关闭")
        navigationController!.popViewController(animated: true)
    }
    
    func choseQRImagePhete(){
        print("相册")
    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if (item.tag == 0) {
            // 选中二维码
        }else{
            // 选中条形码
        
        }
    
    }
    
    
}
