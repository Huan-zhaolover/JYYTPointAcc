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
    
    func alaRequest(type:AlaRequestType,url:String,parameters:[String:AnyObject],complection:@escaping (_ result:Any?,_ error:Error?)->()){

        var alaType:HTTPMethod
        if (type == .GET) {
              alaType = .get;
        }else{
            alaType = .post;
        }
        
        Alamofire.request(url, method: alaType, parameters: parameters).responseJSON { (response) in
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
            //666多张图片上传
            let flag = params["flag"]
            let userId = params["userId"]
            
            multipartFormData.append((flag?.data(using: String.Encoding.utf8.rawValue)!)!, withName: "flag")
            multipartFormData.append((userId?.data(using: String.Encoding.utf8.rawValue)!)!, withName: "userId")
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


