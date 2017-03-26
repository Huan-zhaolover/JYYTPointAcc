//
//  ViewController.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/25.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func loadView() {
        let tv = UITableView(frame: UIScreen.main.bounds)
        tv.dataSource=self
        tv.delegate=self
        view=tv
    }
    // MARK:懒加载
    lazy var dataSoure: [String] = {
        return ["11","22","33","44","55"]
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
// extension 想当于 OC中的category
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    //MARK: -数据源方法
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell2")
        if cell==nil {
            cell=UITableViewCell(style: .default, reuseIdentifier: "cell2")
            
        }
        cell?.textLabel?.text = dataSoure[indexPath.row]
        return cell!
    }
}

