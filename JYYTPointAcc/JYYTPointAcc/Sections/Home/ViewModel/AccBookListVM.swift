//
//  AccBookListVM.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/5/6.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

class AccBookListVM {
    
    static let shareAccListVM : AccBookListVM = AccBookListVM()

}
extension AccBookListVM{

    func loadAccBookList(){
        
        let person_id = UserAccountViewModel.shareIntance.userInfo?.person_id
        let mobile = UserAccountViewModel.shareIntance.userInfo?.mobile
        
        let prama : [String:Any] = ["person_id":person_id ?? "",
                                    "mobile":mobile ?? "",
                                    ]
        
        ALamoNetworkTool.netWorkTools.tokenRequest(type: .GET, url: "app/sys/listBooksData.htm?", parameters: prama,needNetWorkTip: false) { (respon, error) in
            
            JYPrint(respon)
            
        }
        
    }
}
