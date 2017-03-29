//
//  QRScanVC.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/29.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit
import AVFoundation
class QRScanVC: UIViewController,UITabBarDelegate,AVCaptureMetadataOutputObjectsDelegate{
    @IBOutlet weak var customTabbar: UITabBar!
    
    // 点击二维码，条形码进行高度切换
    @IBOutlet weak var contnerView: UIView!
    @IBOutlet weak var contenerViewH: NSLayoutConstraint!
    // 冲进破 聚顶部的高度，从-contenerViewH -> 到0，
    @IBOutlet weak var imageViewToTop: NSLayoutConstraint!
    @IBOutlet weak var iamgeVIewTwo: UIImageView!
//MARK: 懒加载 会话，输入，输出
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
    // 开始扫描名画
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
    func startScan(){
        if !captureSesson.canAddInput(captureDeviceInput){
            return
        }
        if !captureSesson.canAddOutput(outPut){
            return
        }
        captureSesson.addInput(captureDeviceInput)
        captureSesson.addOutput(outPut)
        outPut.metadataObjectTypes = outPut.availableMetadataObjectTypes
        outPut.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        view.layer.insertSublayer(previewLayer, at: 0)
        captureSesson.startRunning()
    }
}
extension QRScanVC{
    
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
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!){
    
        
    }

    
    
}
