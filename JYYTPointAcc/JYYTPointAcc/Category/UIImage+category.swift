//
//  UIImage+category.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/20.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit


extension UIImage {
    
    // 上传的图片是旋转了90度的 图片修正
   class func fixOrientation(aImage: UIImage) -> UIImage {
        // No-op if the orientation is already correct
        if aImage.imageOrientation == .up {
            return aImage
        }
        // We need to calculate the proper transformation to make the image upright.
        // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch aImage.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: aImage.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi/2))
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: aImage.size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi/2))
        default:
            break
        }
        switch aImage.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: aImage.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            break
        }
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        
        //这里需要注意下CGImageGetBitmapInfo，它的类型是Int32的，CGImageGetBitmapInfo(aImage.CGImage).rawValue，这样写才不会报错
        let ctx: CGContext = CGContext(data: nil, width: Int(aImage.size.width), height: Int(aImage.size.height), bitsPerComponent: aImage.cgImage!.bitsPerComponent, bytesPerRow: 0, space: aImage.cgImage!.colorSpace!, bitmapInfo: aImage.cgImage!.bitmapInfo.rawValue)!
        ctx.concatenate(transform)
        switch aImage.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            // Grr...
//            CGRect(x: 0, y: 0, width: aImage.size.width, height: aImage.size.height)
            ctx.draw(aImage.cgImage!, in: CGRect(x: 0, y: 0, width: aImage.size.height, height: aImage.size.width))
//            ctx.draw(aImage.cgImage, rect: CGRect(x: 0, y: 0, width: aImage.size.height, height: aImage.size.width))
            
 
        default:
            ctx.draw(aImage.cgImage!, in: CGRect(x: 0, y: 0, width: aImage.size.width, height: aImage.size.height))

//            CGContextDrawImage(ctx, CGRect(x: 0, y: 0, width: aImage.size.width, height: aImage.size.height), aImage.cgImage)
        }
        
        // And now we just create a new UIImage from the drawing context
        let cgimg: CGImage = ctx.makeImage()!
        let img: UIImage = UIImage(cgImage: cgimg)
        
        return img
    }
    
   
   
    
    /// 根据尺寸重写绘图
    ///
    /// - Parameters:
    ///   - aimage: 需要绘制的图像
    ///   - size:  绘制的尺寸
    /// - Returns: 绘制好的UIImage
    static func getNoMisalignedImage(aimage:UIImage,size:CGSize)->UIImage?{
        //  处理图片拉伸渲染消耗GPU，或者混合模式，PNG图片透明混合渲染问题
        //  PNG图片是支持透明的，JPG图片是不支持透明的
        // 开启图像上下文
        // 图像上下文，在内存中开辟一个地址，跟屏幕无关，
        // 参数 size 绘图的尺寸  ||不透明：false(透明),true(不透明)  || scale 屏幕分辨率，默认使用1.0，可以使用0，是当前屏幕的分辨率
        // 绘图，指定固定区域内的拉伸屏幕
        // 取得结果
        // 关闭上下文
        
        let rect = CGRect(origin: CGPoint(), size: size)
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        aimage.draw(in: rect)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    /// 获取圆角半径
    ///
    /// - Parameters:
    ///   - aimage: 原图
    ///   - size: 绘制size
    ///   - backGroudColor:  绘制圆角的背景色 ,默认是白色背景
    /// - Returns: 绘制好的背景
    func getRoundedImage(size:CGSize,backGroudColor:UIColor?=UIColor.white)->UIImage?{
    
        
        // 开启图像上下文
        // 图像上下文，在内存中开辟一个地址，跟屏幕无关，
        // 参数 size 绘图的尺寸  ||不透明：false(透明),true(不透明)  || scale 屏幕分辨率，默认使用1.0，可以使用0，是当前屏幕的分辨率
        // 背景填充
        // 进行路径裁剪  -> 剪切之后再路径内绘图，设置为不透明，呈现黑色，需要裁剪前进行背景填充
        // 绘图，指定固定区域内的拉伸屏幕
        // 设置边线
        // 取得结果
        // 关闭上下文
        
        let rect = CGRect(origin: CGPoint(), size: size)
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        
        backGroudColor?.setFill()
        UIRectFill(rect)
        let path = UIBezierPath(ovalIn: rect)
        path.addClip()
        
        self.draw(in: rect)
        
        UIColor.red.setStroke()
        path.lineWidth = 2 // 默认是1
        path.stroke()
    
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
}
