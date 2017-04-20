//
//  BLHttpSessionsRequest.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/20.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit
import Alamofire
//创建请求类枚举
enum RequestType: Int {
    case requestTypeGet
    case requestTypePost
}

//创建一个闭包(注:oc中block)
typealias sendVlesClosure = (AnyObject?, NSError?)->Void
typealias uploadClosure = (AnyObject?, NSError?,Int64?,Int64?,Int64?)->Void

class BLHttpSessionsRequest: NSObject {
    
    // --GET请求获取JSON数据
    func BLGetJSONDataWithUrl(url: String, parameters: AnyObject, successed:@escaping (_ responseObject: AnyObject?) -> (), failed: @escaping (_ error: NSError?) -> ()) {
        
    

        Alamofire.request(url, method: .get,  parameters: parameters as? [String : AnyObject]).responseJSON(completionHandler: { (data) in
            if data.result.isSuccess {
                successed(data.data as AnyObject)
            }else {
                failed(data.result.error as NSError?)
            }
            
        })
 
    }
    // --文件上传
    //fileURL实例:let fileURL = NSBundle.mainBundle().URLForResource("Default",withExtension: "png")
    func BLUpload(URLString:String,fileURL:URL,progress:(_ bytesWritten: Int64?,_ totalBytesWritten: Int64?,_ totalBytesExpectedToWrite: Int64?) -> Void, responseResult:(_ responseValue: AnyObject?,_ error: NSError?) -> Void) {
        
        
        
        Alamofire.download(URLString, parameters: nil, encoding:  URLEncoding.default,to: nil).responseJSON { (respons) in
            
        }
        
        
        Alamofire.upload(fileURL, to: URLString).uploadProgress(closure: { (progress) in
            
            
            
        }) .responseJSON { (iiiiii) in
            
        }
        
        
    }
}


