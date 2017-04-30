//
//  textSwiftVC.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/30.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

class textSwiftVC: UIViewController {

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
