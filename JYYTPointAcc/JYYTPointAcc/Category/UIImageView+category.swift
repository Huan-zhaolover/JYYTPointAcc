//
//  UIImageView+category.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/29.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit
import SDWebImage


extension UIImageView {
    
    /// 设置图片
    ///
    /// - Parameters:
    ///   - urlString: 图片地址
    ///   - placeholerImage: 占位图
    ///   - isAvatar: 是不是设置圆角，默认是不设置
    func jy_setImage(urlString:String?,placeholerImage:UIImage?,isAvatar:Bool = false){
        guard let urlStr = urlString ,let url = URL(string: urlStr) else {
             image = placeholerImage
                return
        }
        sd_setImage(with: url, placeholderImage: placeholerImage, options: [], progress: nil) {[weak self]  ( image, _, _, _) in
            if isAvatar {
              self?.image = image?.getRoundedImage(size: (self?.bounds.size)!)
            }
        }
    }
    
    /*  downloadImage 是核心方法，
      图像完成下砸之后会自动保存在沙盒中，文件路径是URL的md5
     如果沙盒中已经存在缓存的图像，后续使用SD通过URL的加载图像，都是从沙盒中取图像
      不会发起网络请求，同时，回调方法同样会调用，返回的是从沙盒返回的
     
     
     */
    
    /// 根据图片地址下载图片
    ///
    /// - Parameters:
    ///   - urlString: 图片urlstring
    ///   - complention: 完成回调
    static func jy_downImage(urlString:String?,complention:@escaping (UIImage?, Data?, Error?, Bool)->())->(){
        guard let urlStr = urlString ,let url = URL(string: urlStr) else {
             return
        }
        SDWebImageManager.shared().imageDownloader?.downloadImage(with: url, options: [], progress: nil, completed: complention)
        
    }
    
}
