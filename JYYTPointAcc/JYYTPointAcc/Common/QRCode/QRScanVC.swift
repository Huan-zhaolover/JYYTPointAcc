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
    private lazy var captureSesson :AVCaptureSession = AVCaptureSession()
    private lazy var captureDeviceInput : AVCaptureDeviceInput? = {
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        do{
            let input = try AVCaptureDeviceInput(device: device)
            return input
        }catch{
            print(error)
            return nil
        }
    }()
    private lazy var outPut :AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    private lazy var previewLayer : AVCaptureVideoPreviewLayer = {
        
        let layer:AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSesson)
        layer.frame = UIScreen.main.bounds
        return layer
    }()
    private lazy var drawCornerLayer : CALayer = {
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
        startScan()
    }
    // 点击跳转我的名片
    @IBAction func myQRCardClilck(_ sender: Any) {
        let VC = MyQRCardVC()
        navigationController?.pushViewController(VC, animated: true)
    }
    
    // 开始扫描动画
    func imageViewStartScanAnimation(){
        let  currentH = contenerViewH.constant;
        imageViewToTop.constant = -currentH
        iamgeVIewTwo.layoutIfNeeded()
        UIView.setAnimationRepeatCount(MAXFLOAT)
        UIView.animate(withDuration: 1) {
            self.imageViewToTop.constant = currentH
            self.iamgeVIewTwo.layoutIfNeeded()
        };
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
    
    // 清空边角连线
    func cleanCorners(){
        if (drawCornerLayer.sublayers == nil) || (drawCornerLayer.sublayers?.count == 0) {
            return
        }
        for subLayer in drawCornerLayer.sublayers! {
            subLayer.removeFromSuperlayer()
        }
    }
    
    // 添加边角连线
    func  startDrawConreLayer(){
    
        
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
        contnerView.layoutIfNeeded()
        imageViewStartScanAnimation()
    }
    //  只要解析到数据就会调用
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!){
       //   清除图层
        cleanCorners()
        let astrinng = metadataObjects.last
        print(astrinng!);
        
        // 转换坐标
        for obje in metadataObjects  {
            if obje is  AVMetadataMachineReadableCodeObject{
            
                
                
            }
        }
        
    }
    
}
