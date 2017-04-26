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


// MARK: - ----------------封装网址-Token
extension  ALamoNetworkTool {

    
    /// 封装参数的request
    ///
    /// - Parameters:
    ///   - type: .GET or .POST
    ///   - url: urlString,urlPath
    ///   - parameters: 参数
    ///   - isneedEncryToken: 登录之前的借口需要自己加密需要加密的token  其余传登录之后返回的token
    ///   - needNetWorkTip: 启动的时候没有网络判断
    ///   - complection: 完成的回调
    
    func tokenRequest(type:AlaRequestType,url:String,parameters:[String:Any],
                      isneedEncryToken:Bool = true ,
                      needNetWorkTip:Bool = true,
                      complection:@escaping (_ result:Any?,_ error:Error?)->()){
       
        /*
         mobile/reg_step_one.htm?token=  // 分享的是拼接版本号的token
         
         // isneedEncryToken  登录之前的借口需要自己加密需要加密的token  其余传登录之后返回的token
         
         app/loginByEncry.htm?  // 登录
         app/sys/compareVersion.htm?  // 比较版本号
         app/checkMobile.htm? 验证手机号
         app/senMessage.htm? 发生验证码
         app/checkVerifycode.htm  验证验证码
         app/reg.htm?   注册
         app/updatePwd.htm?   更改密码
         
         // needNetWorkTip  启动的时候没有网络判断
         app/sys/listBooksData.htm?  加载首页账本的时候，加载广告业，查询红点数的时候，此时网络监测还没有返回，不尽兴网络请求判断网络请求
         app/sys/listBooks.htm?
         app/sys/queryHaveNewMessage.htm?
         /app/person/querySplash.htm?
         
         */
        
        /*
         // 加密之后的token
         NSString *timestring=[NSString stringWithFormat:@"%@|%@",secreat,[NSString nowTimeDetial]];
         NSString *encryptString=[NSString encrypt:timestring];
         [theTureDic setValue :encryptString forKey:@"token"];
         
         */
        let totlalUrl = JYAppUrl.appending(url)   // 拼接全路径
        // |
        
        var tokenDic : [String:Any] = [:]
        if isneedEncryToken {
            tokenDic["token"] = UserAccountViewModel.shareIntance.userInfo?.appkey // 登录返回的token
        }else{
            let aency = APPSecreat + "|".appending(Date.nowTimeDetail())
            tokenDic["token"] = NSString.encrypt(aency)!
        }
        
        if needNetWorkTip {
            let appdelegate =  APPDELEGATE as! AppDelegate
            if !appdelegate.isHaveNet {
                return;
            }
            /*
             AppDelegate *appdele=(AppDelegate*)APPDELEGATE;
             if (!appdele.isHaveNet) {
             [KVNProgress showWithStatus:@"当前没有网络"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [KVNProgress dismiss];
             });
             return ;
             }
             */
        }
        for (key,value) in parameters {
            tokenDic[key] = value
        }
        request(type: type, url: totlalUrl, parameters: tokenDic, complection: complection)
    
    }
}
// MARK: - -----------------封装的网络请求 GET POST
extension  ALamoNetworkTool {
    func request(type:AlaRequestType,url:String,parameters:[String:Any],complection:@escaping (_ result:Any?,_ error:Error?)->()){
        var alaType:HTTPMethod
        if (type == .GET) {
              alaType = .get;
        }else{
            alaType = .post;
        }

        Alamofire.request(url, method: alaType, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
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

// MARK: - -----------------图片上传
extension  ALamoNetworkTool {
    
    func getImageRequest(urlstring:String ,
                    params:[String:AnyObject],
                    datas:[Data],
                    complection:@escaping (_ result:[String:AnyObject]?,_ error:Error?)->()) {
        
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


