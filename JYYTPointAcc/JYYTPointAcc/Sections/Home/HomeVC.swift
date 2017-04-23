//
//  HomeVC.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/27.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

import Alamofire

class HomeVC: BaseViewController{

    private lazy var homeAnimatir : HomePopOverAnimator = HomePopOverAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isHadLoggin {
            nologvvv.addRotationAnimation()
        }
        
    
        
        setHomeNavBars()
        textbase64()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        tabBarController?.tabBar.isHidden = isHadLoggin
    }
    
    
    func  setHomeNavBars(){
        if isHadLoggin {
           
            navItem.leftBarButtonItem =  UIBarButtonItem(titleStr: "账本", target: self, action: #selector(changeAccoountBook))
            navItem.rightBarButtonItem = UIBarButtonItem(title: "消息", style: .plain, target: self, action: #selector(messageList))
        }else{
            setNavgationBarNoLogedItems()
        }
    }
    
    
    func changeAccoountBook(){
        let vc =  LeftChoseAccountBookVC()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = homeAnimatir
        
        present(vc, animated: true, completion:nil)
    }
    
    
    
    func messageList(){
         let  vc  = QRScanVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func  textbase64(){
        
    
        
        
    }
}
