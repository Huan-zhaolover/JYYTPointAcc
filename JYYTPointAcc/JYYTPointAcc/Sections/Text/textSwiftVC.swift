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
