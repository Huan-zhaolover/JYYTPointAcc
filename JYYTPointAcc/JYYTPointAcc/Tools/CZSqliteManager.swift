//
//  CZSqliteManager.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/6/23.
//  Copyright © 2017年 shjy. All rights reserved.
//

import Foundation
import FMDB

/*
sqlite 管理器
 1.创建并且打开数据库 2.创建数据库  3增删改查 FMDB - 队列‘
 */

class CZSQLiteManager {
    // 单例
    static let shared = CZSQLiteManager()
    // 数据库队列
    let queue: FMDatabaseQueue
    // 构造函数
    private init(){
    // 数据库的全路径  - path
        let dbname = "jypoint.db"
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
        path = (path as NSString).appendingPathComponent(dbname)
        JYPrint("数据库的路径：" + path)
        queue = FMDatabaseQueue(path: path)
        
        NotificationCenter.default.addObserver(self, selector: #selector(clearDB), name: NSNotification.Name.UIApplicationDidReceiveMemoryWarning, object: nil)
    }
    
    @objc func clearDB() {
        // 清楚缓存
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func updateStatus(userId:String,array:[[String:AnyObject]]){
        // 1 准备SQL
        let sql = "INSERT OR REPLACE INTO T_status (statusId,userId,status) VALUES (?,?,?);"
        // 执行 SQL
        queue.inTransaction { (db, roolback) in
            for dict in array {
                guard let statusId = dict["idString"] as? String,
                let jsondata = try? JSONSerialization.data(withJSONObject: dict, options: [])
                    else{
                    continue;
                }
                // 执行sql
                if db?.executeUpdate(sql, withArgumentsIn: [statusId,userId,jsondata]) == false{
                    // 需要回滚 rollback  = true
                    //  1.0,2.0 -> rollback.memory = true
                    // 3.0 rollback.pointee = true
                    roolback?.pointee = true;
                    
                    break;
                }
                
                
            }
        }
        
    }
    
    
}
