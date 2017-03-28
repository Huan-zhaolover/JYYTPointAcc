//
//  HomeVC.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/27.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

class HomeVC: BaseViewController{

    private lazy var homeAnimatir : HomePopOverAnimator = HomePopOverAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isHadLoggin {
            nologvvv.addRotationAnimation()
        }
    
        setHomeNavBars()
        
        // Do any additional setup after loading the view.
    }
    func  setHomeNavBars(){
        if isHadLoggin {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "账本", style: .plain, target: self, action: #selector(changeAccoountBook))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "消息", style: .plain, target: self, action: #selector(messageList))
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
