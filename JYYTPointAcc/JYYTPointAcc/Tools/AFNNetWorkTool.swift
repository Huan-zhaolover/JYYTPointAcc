//
//  AFNNetWorkTool.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/18.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

import AFNetworking

enum AFNnetRequsetType {
    case  POST
    case  GET
}

class AFNNetWorkTool: AFHTTPSessionManager {
    static let AFNTools:AFNNetWorkTool = {
        let tools = AFNNetWorkTool()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        return tools
        }()
}

extension AFNNetWorkTool {

    typealias callBack = (_ aresult:Any?,_ erro:Error)->()
    
    // 加载
    func loadAccessToken(code: String, finished: @escaping callBack) {
    
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        let params = ["client_id": "",
                      "client_secret": "",
                      "grant_type": "authorization_code",
                      "code": "",
                      "redirect_uri": ""]
        afnRequest(methodType: .POST, urlString: urlString, parames: params as [String : AnyObject], finished: finished as! (Any?, Error?) -> ())
    
       
    
    }
}
// 内部封装AFN 请求
extension AFNNetWorkTool{

    func afnRequest(methodType:AFNnetRequsetType,urlString:String,parames:[String:AnyObject]?,finished:@escaping (_ result:Any?,_ error:Error?)->()){
        
        // 定义成功的回调
        let seccessBlck = { (task:URLSessionDataTask,resuurt:Any?)->() in
            finished(resuurt,nil)
        }
        // 定义失败的回调
        let faitureBlock = { (tast:URLSessionDataTask?,error:Error)->() in
            finished (nil,error)
        }
        
        if methodType == .GET {
            get(urlString, parameters: parames, progress: nil, success: seccessBlck, failure: faitureBlock)
            
        }else{
            post(urlString, parameters: parames, progress: nil, success: seccessBlck, failure: faitureBlock)
        }
        
    }
}

