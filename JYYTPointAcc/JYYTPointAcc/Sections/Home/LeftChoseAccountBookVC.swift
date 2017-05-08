//
//  LeftChoseAccountBookVC.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/28.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit
// 左侧抽屉选择账本
class LeftChoseAccountBookVC: UIViewController {
    
    lazy var dataArray :Array = Array<Any>()
    
    @IBOutlet weak var theTableView: UITableView!
    let accListVM = AccBookListVM.shareAccListVM
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AllViewColor
        
        setTableView()
        
        loadList()
    }
    func setTableView() {
        
        theTableView?.register(UINib.init(nibName: "HomeListCell", bundle: nil), forCellReuseIdentifier: "HomeListCell");
        theTableView?.rowHeight = UITableViewAutomaticDimension
        theTableView?.estimatedRowHeight = 100
    }
    
    // MARK:-----加载账本列表
    func  loadList(){
        accListVM.loadAccBookList {[weak self]  (isSucces, viewmodes) in

            if !isSucces {
                return;
            }
            self?.dataArray.removeAll()
            self?.dataArray += viewmodes!
            self?.theTableView?.reloadData()
            JYPrint(viewmodes);
            
        }
    }

    // 编辑账本
    @IBAction func editButtonClick(_ sender: Any) {
    }
   // 新建账本
     @IBAction func newButtonClick(_ sender: Any) {
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension LeftChoseAccountBookVC : UITableViewDataSource,UITableViewDelegate{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeListCell", for: indexPath) as! HomeListCell
        
        let listmodel = dataArray[indexPath.row] as! AccBookVM
        cell.listViewModel = listmodel
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        
    }
    
}

