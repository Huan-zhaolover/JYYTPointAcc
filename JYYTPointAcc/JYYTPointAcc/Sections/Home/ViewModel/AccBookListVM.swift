//
//  AccBookListVM.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/5/6.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit
import SwiftyJSON

class AccBookListVM {
    
    static let shareAccListVM : AccBookListVM = AccBookListVM()

}
extension AccBookListVM{

    func loadAccBookList(complection:@escaping (_ isSuccess:Bool,_ viewModels:Array<Any>?)->()){
        
        let person_id = UserAccountViewModel.shareIntance.userInfo?.person_id
        let mobile = UserAccountViewModel.shareIntance.userInfo?.mobile
        
        let prama : [String:Any] = ["person_id":person_id ?? "",
                                    "mobile":mobile ?? "",
                                    ]
        
        ALamoNetworkTool.netWorkTools.tokenRequest(type: .GET, url: "app/sys/listBooksData.htm?", parameters: prama,needNetWorkTip: false) { (respon, error) in
            
            if error != nil{
                complection(false,nil);
                return
            }
            let responJson = JSON(respon!)
            var models = Array<Any>()
            if let accs = responJson["data"].arrayObject {
                for aAcc in accs {
                    let Account =  AccountBookModel.init(value: aAcc)
                    let accviewmolde = AccBookVM.init(accBookmodel: Account)
                    models.append(accviewmolde)
                }
                complection(true,models);
            }else{
                // 数组为空
                complection(false,nil);
            }
        }
        
    }
}
