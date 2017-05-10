//
//  textSwiftVC.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/30.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

class textSwiftVC: UIViewController {

    let lable = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textGroup()
        // Do any additional setup after loading the view.
    }

    
    func textGroup(){
        let group = DispatchGroup()
        
        let queue = DispatchQueue.global()
        group.enter()
        queue.async {
            print("aaaaa\(Thread.current)")
            group.leave()
        }
        
        group.enter()
        queue.async {
            print("bbbbb\(Thread.current)")
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            print("come here is end \(Thread.current)")
        }
        
        let table = UITableView()
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 300;
        
        
    }
    /*
     属性字符串
     1.NSTextStorage  管理NSLayoutManager 对象，字符或者属性变化的时候，通知LayoutManager重新布局并显示文本
     2.NSLayoutManager 负责协调布局，显示NSTextStorage对象中保存的字符，将字形设置为一系列NSTextContainer 对象，然后以系列文本视图对象显示
     3.NStextContainer 也可以定义一个排除路径，定义一下矩形区域，在layoutSubviews中更新调用
     
     
     
     */
    func textTextKit2(){
    
    }
    func textTextKit(){
      
        let attchment = NSTextAttachment()
        // 图片附件
        attchment.image = UIImage(named: "hehheheh");
        // lineHeight 大致和字体的大小相等
        let height = lable.font.lineHeight
        // frame x,y 决定当前控件，相对父控件的位置
        // bounds ,x,y 决定内部子控件相对远点的位置
        attchment.bounds = CGRect(x: 0, y: -4, width: height, height: height)
        
        //图片属性文本
        let attst1 = NSAttributedString(attachment: attchment)
        
        let attrStrM = NSMutableAttributedString(string: "我")
        attrStrM.append(attst1)
        attrStrM.append(NSAttributedString(string: "99999"))
        
        lable.attributedText = attrStrM
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
