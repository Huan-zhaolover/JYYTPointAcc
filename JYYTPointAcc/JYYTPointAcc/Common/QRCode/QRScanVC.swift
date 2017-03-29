//
//  QRScanVC.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/29.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit
import AVFoundation
class QRScanVC: UIViewController,UITabBarDelegate{
    @IBOutlet weak var customTabbar: UITabBar!
    
    // 点击二维码，条形码进行高度切换
    @IBOutlet weak var contnerView: UIView!
    @IBOutlet weak var contenerViewH: NSLayoutConstraint!
    // 冲进破 聚顶部的高度，从-contenerViewH -> 到0，
    @IBOutlet weak var imageViewToTop: NSLayoutConstraint!
    @IBOutlet weak var iamgeVIewTwo: UIImageView!
//MARK: 懒加载 会话，输入，输出，预览图层
     lazy var captureSesson :AVCaptureSession = AVCaptureSession()
     lazy var captureDeviceInput : AVCaptureDeviceInput? = {
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        do{
            let input = try AVCaptureDeviceInput(device: device)
            return input
        }catch{
            print(error)
            return nil
        }
    }()
     lazy var outPut :AVCaptureMetadataOutput = AVCaptureMetadataOutput()
     lazy var previewLayer : AVCaptureVideoPreviewLayer = {
        
        let layer:AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSesson)
        layer.frame = UIScreen.main.bounds
        return layer
    }()
     lazy var drawCornerLayer : CALayer = {
        let layer = CALayer()
        layer.frame = UIScreen.main.bounds
        return layer
    }()
    
 //MARK: viewDidLod viewWillAppear
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(closeQRVC))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "相册", style: .plain, target: self, action: #selector(choseQRImagePhete))
        customTabbar.selectedItem = customTabbar.items![0]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 开始扫描动画
        imageViewStartScanAnimation()
        // 2.开始扫描
//        startScan()
    }
    // 点击跳转我的名片
    @IBAction func myQRCardClilck(_ sender: Any) {
        let VC = MyQRCardVC()
        navigationController?.pushViewController(VC, animated: true)
    }
    
    // 开始扫描动画
    func imageViewStartScanAnimation(){
 
        self.imageViewToTop.constant = -self.contenerViewH.constant;
        self.iamgeVIewTwo.layoutIfNeeded()
        
        UIView.animate(withDuration: 1, animations: {
            self.imageViewToTop.constant = self.contenerViewH.constant;
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.iamgeVIewTwo.layoutIfNeeded()
        })
    }
    // 开始扫描
    func startScan(){
        // 判断能否添加输入
        if !captureSesson.canAddInput(captureDeviceInput){
            return
        }
        // 判断能否添加输出
        if !captureSesson.canAddOutput(outPut){
            return
        }
        // 添加输入，输出
        captureSesson.addInput(captureDeviceInput)
        captureSesson.addOutput(outPut)
        // 设置能解析的输出类型
        outPut.metadataObjectTypes = outPut.availableMetadataObjectTypes
        // 设置输出对象代理
        outPut.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        // 添加预览图层
        view.layer.insertSublayer(previewLayer, at: 0)
        // 开始扫描
        captureSesson.startRunning()
    }
}


extension QRScanVC:AVCaptureMetadataOutputObjectsDelegate{
    
    func closeQRVC(){
        print("关闭")
        navigationController!.popViewController(animated: true)
    }
    func choseQRImagePhete(){
        print("相册")
    }
    
    // 点击切换二维码条形码切换
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if (item.tag == 0) {
            // 选中二维码
            contenerViewH.constant = 300
        }else{
            // 选中条形码
            contenerViewH.constant = 150
        }
        iamgeVIewTwo.layer.removeAllAnimations()
         imageViewStartScanAnimation()
    }
    //  只要解析到数据就会调用
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!){
       //   清除图层
        cleanCorners()
        let astrinng = metadataObjects.last as! AVMetadataMachineReadableCodeObject
        print(astrinng.stringValue);
        // 转换坐标
        for obje in metadataObjects  {
            if obje is  AVMetadataMachineReadableCodeObject{
                 let codeObje = previewLayer.transformedMetadataObject(for: obje as! AVMetadataObject)
                if  codeObje != nil {
                    startDrawConreLayer(codeObje: codeObje as! AVMetadataMachineReadableCodeObject)
                }
            }
        }
        
    }
    // 添加边角连线 绘制图形
    func  startDrawConreLayer(codeObje:AVMetadataMachineReadableCodeObject){
        if codeObje.corners.isEmpty {
            return
        }
        // 创建涂层
        let layer = CAShapeLayer()
        layer.lineWidth = 4.0
        layer.strokeColor = UIColor.red.cgColor
        layer.fillColor = UIColor.clear.cgColor
        // 创建路径
        let path = UIBezierPath()
        var point  = CGPoint.zero
        var index :Int = 0
        // 移动一个点上
        point = CGPoint(dictionaryRepresentation: codeObje.corners[index] as! NSDictionary)!
        path.move(to: point)
        // 移动下一个点
        while index < codeObje.corners.count {
            point = CGPoint(dictionaryRepresentation: codeObje.corners[index] as! NSDictionary)!
            path.move(to: point)
            index = index + 1
        }
        // 关闭路径
        path.close()
        //  绘制路径
        layer.path = path.cgPath
        // 生成图层添加到drawLayer 上
        drawCornerLayer.addSublayer(layer)
        
    }
    
    // 清空边角连线
    func cleanCorners(){
        if (drawCornerLayer.sublayers == nil) || (drawCornerLayer.sublayers?.count == 0) {
            return
        }
        for subLayer in drawCornerLayer.sublayers! {
            subLayer.removeFromSuperlayer()
        }
    }
    

    
}
