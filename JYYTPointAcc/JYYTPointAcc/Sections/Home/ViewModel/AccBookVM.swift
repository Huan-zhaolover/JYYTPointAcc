//
//  AccBookVM.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/5/6.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit
import SwiftyJSON
// AccountBookModel
class AccBookVM {
    
    var personCount:String?
    
    var aModel :AccountBookModel?{
        didSet{
            personCount = (aModel?.partner_count)! == 0 ? "":"\((aModel?.partner_count)!)人"
        }
    }
    
    init(accBookmodel:AccountBookModel) {
            aModel = accBookmodel
    }
    func loadAccounDetailRequest(complection:@escaping (_ isSucesss:Bool)->()){
      
        let person_id = UserAccountViewModel.shareIntance.userInfo?.person_id
        let mobile = UserAccountViewModel.shareIntance.userInfo?.mobile
        let books_id = aModel?.id
        
        let pramas:[String:Any] = ["person_id":person_id ?? "",
                                   "mobile":mobile ?? "",
                                   "books_id":books_id ?? ""
                                    ];
        ALamoNetworkTool.netWorkTools.tokenRequest(type: .GET, url: "app/sys/listBooks.htm?", parameters: pramas) {[weak self]  (respon, error) in
            if error != nil{
                complection(false)
                return
            }
            
            let resonJson = JSON(respon!)
            if let booksStatis = resonJson["data"][0]["booksStatis"].dictionaryObject {
                
                self?.aModel?.booksStatis = AccStatisticsModel.init(value: booksStatis);
                complection(true)

            }else{
                complection(false)
            }
            
            
        }

        
        
    }
    
    
    
}
