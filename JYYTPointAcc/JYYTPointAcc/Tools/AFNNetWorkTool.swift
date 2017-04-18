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
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
        }()
}
// 内部封装AFN 请求
extension AFNNetWorkTool {

    typealias callBack = (_ aresult:AnyObject?,_ erro:Error)->()

    
    
    func afnRequest(methodType:AFNnetRequsetType,urlString:String,parames:[String:AnyObject]?,finished:@escaping (_ result:Any?,_ error:Error?)->()){
    
        // 定义成功的回调
        let seccessBlck = { (task:URLSessionDataTask,resuurt:Any?)->() in
            finished(resuurt,nil)
        }
        // 定义失败的回调
        let faitureBlock = { (tast:URLSessionDataTask?,error:Error)->() in
            finished (tast,error)
        }
        
        if methodType == .GET {
            get(urlString, parameters: parames, progress: nil, success: seccessBlck, failure: faitureBlock)
            
        }else{
            post(urlString, parameters: parames, progress: nil, success: seccessBlck, failure: faitureBlock)
        }
    
    }
}
