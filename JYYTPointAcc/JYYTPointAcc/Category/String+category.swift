//
//  String+category.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/1.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

extension String {

    /**
     将当前字符串拼接到cache目录后面 如果没有路径，返回cache目录
     */
    
    static func cacheDir(path:String?) -> String{
        let cactchpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!  as NSString
        if path == nil {
            return cactchpath as String
        }else{
            return cactchpath.appendingPathComponent((path!as  NSString).lastPathComponent)
        
        }
    }
    /**
     将当前字符串拼接到doc目录后面 ，如果没有路径，返回doc目录
     */
    static func docDir(path:String?) -> String
    {
        let docupath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!  as NSString
        if path == nil {
            return docupath as String

        }else{
            return docupath.appendingPathComponent((path! as NSString).lastPathComponent)
        }
    }
    /**
     将当前字符串拼接到tmp目录后面  如果没有路径，返回tmp目录
     */
    static func tmpDir(path:String?) -> String
    {
        let tempopath = NSTemporaryDirectory() as NSString
        if path == nil {
            return tempopath as String
        }else{
            return tempopath.appendingPathComponent((path! as NSString).lastPathComponent)
        }
    
    }

}
