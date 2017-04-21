//
//  ALamoNetworkTool.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/20.
//  Copyright © 2017年 shjy. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


enum AlaRequestType {
    case POST
    case GET
}

class ALamoNetworkTool  {
  static let netWorkTools = ALamoNetworkTool()
    
}

// 封装的网络请求 GET POST 图片上传
extension  ALamoNetworkTool {
    
    func alaRequest(type:AlaRequestType,url:String,parameters:[String:Any],complection:@escaping (_ result:Any?,_ error:Error?)->()){

        /*
         // 加密之后的token
         NSString *timestring=[NSString stringWithFormat:@"%@|%@",secreat,[NSString nowTimeDetial]];
         NSString *encryptString=[NSString encrypt:timestring];
         [theTureDic setValue :encryptString forKey:@"token"];
         
         */
        let totlalUrl = JYAppUrl.appending(url)   // 拼接全路径
        // |
        
        let aency = APPSecreat + "|".appending(Date.nowTimeDetail())
        var tokenDic : [String:Any] = ["token":NSString.encrypt(aency)! ]

        for (key,value) in parameters {
            tokenDic[key] = value
        }
        
        var alaType:HTTPMethod
        if (type == .GET) {
              alaType = .get;
        }else{
            alaType = .post;
        }

        Alamofire.request(totlalUrl, method: alaType, parameters: tokenDic).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value as? [String: AnyObject] {
                    complection(value,nil)
                }
                break
            case .failure(let error):
                complection(nil,error)
                break
            }
    }
    

    }
}

// 图片上传
extension  ALamoNetworkTool {
    
    func getRequest(urlstring:String ,params:[String:AnyObject],datas:[Data],complection:@escaping (_ result:[String:AnyObject]?,_ error:Error?)->()) {
        
        let headers = ["content-type":"multipart/form-data"]
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            //把剩下的两个参数作为字典参数,
            for (key, value) in params {
                multipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
             }
            for i in 0..<datas.count {
                multipartFormData.append(datas[i], withName: "appPhoto", fileName: "图片\(i)", mimeType: "image/png")
            }
        },
                         to: urlstring,
                         headers: headers) { (encodingResult) in
                            
                            switch encodingResult {
                            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                                upload.responseJSON(completionHandler: { (adataResponse) in
                                    
                                    if let aValue = adataResponse.result.value as? [String:AnyObject] {
                                        complection(aValue,nil)
                                    }
                                })
                                break
                            case .failure(let error):
                                complection(nil,error)
                                break
                            }
                            
        }
    }
    
}


