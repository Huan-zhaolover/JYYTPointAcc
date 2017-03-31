//
//  MyQRCardVC.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/29.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

class MyQRCardVC: UIViewController {

    @IBOutlet weak var qrCardImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "我的名片"
        let QRImage = creatQrImage(astring: "fffff")
        qrCardImageView.image = QRImage
        
    }
    // 4.生成二维码
    func creatQrImage(astring:String) -> UIImage {
        // 创建滤镜
        let filer = CIFilter.init(name: "CIQRCodeGenerator")
        // 还原滤镜的设置
        filer?.setDefaults()
        // 设置数据
        filer?.setValue(astring.data(using: .utf8), forKey: "inputMessage")
        // 从滤镜中取出图片
        let fileCiImage = filer?.outputImage
        // 创建头像
        let bgImage = createNonInterpolatedUIImageFormCIImage(image: fileCiImage!, size: 300)

        // 合成图片
        // 返回头像
        return bgImage
    }

    /**
     根据CIImage生成指定大小的高清UIImage
     
     :param: image 指定CIImage
     :param: size    指定大小
     :returns: 生成好的图片
     */
    private func createNonInterpolatedUIImageFormCIImage(image: CIImage, size: CGFloat) -> UIImage {
        
        let extent: CGRect = image.extent.integral
        let scale: CGFloat = min(size/extent.width, size/extent.height)
        
        // 1.创建bitmap;
        let width = extent.width * scale
        let height = extent.height * scale
        let cs: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: 0)!
        
        let context = CIContext(options: nil)
//        let bitmapImage: CGImage = context.createCGImage(image, from: extent)!
        
        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: scale, y: scale);
        
//        CGContextDrawImage(bitmapRef, extent, bitmapImage);
        
//        CGContext.makeImage(bitmapRef)
        // 2.保存bitmap到图片
        let scaledImage: CGImage = bitmapRef.makeImage()!
        
        return UIImage.init(cgImage: scaledImage)
    }

    
}
