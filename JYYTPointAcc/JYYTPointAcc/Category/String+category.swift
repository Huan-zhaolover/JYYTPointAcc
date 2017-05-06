//
//  String+category.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/1.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

// MARK: - 类方法
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

// MARK: - 对象方法
extension String {

    func sizeWithFont(fontsize:CGFloat,maxWidth:CGFloat = CGFloat.greatestFiniteMagnitude)->(CGSize){

        let font  = UIFont.systemFont(ofSize: fontsize)
        let attibute = [NSFontAttributeName:font];
        var size = CGRect()
        let size2 = CGSize(width: maxWidth, height: 0)//设置label的最大宽度
        size = self.boundingRect(with: size2, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attibute , context: nil);
        return size.size;
        
    }
}
