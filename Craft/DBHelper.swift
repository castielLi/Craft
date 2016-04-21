//
//  DBHelper.swift
//  Craft
//
//  Created by castiel on 16/4/21.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation
import FMDB

private let _sharedService: DBHelper = { DBHelper() }()


class DBHelper {
    class func sharedInstance() -> DBHelper {
        return _sharedService
    }
    
    var database : FMDatabase?
    
    init()
    {
        let documentsFolder: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        let path = documentsFolder.stringByAppendingString("/craft.sqlite")
        
        //如果当前地址没有这个文件。那么fmdatabase会给你创建一个sqlite文件
        database = FMDatabase(path: path)
        
        if !database!.open() {
            print("Unable to open database")
        }
        
        do {
            // 为第一次创建数据库进行准备
            // 创建 本地活动通知表
            try database!.executeUpdate("CREATE TABLE IF NOT EXISTS RemindActivity(uuid text, activityid text)" , withArgumentsInArray: nil)
        }catch{
            
        }
    }
    
    func excuteSql(sqlString:String , array: Array<String>)->Bool{
        do{
          try database!.executeUpdate(sqlString,withArgumentsInArray: array)
          return true
        }catch{
           return false
        }
    }

    func searchDataFromDB(sqlString : String ,array: Array<String> , outParameters: Array<String>)->NSMutableDictionary?{
        do{
         let result = try database!.executeQuery(sqlString, values: array)
        
        var resultDic = NSMutableDictionary()
        while result.next(){
            for para in outParameters{
               resultDic.addEntriesFromDictionary([para : result.stringForColumn(para)])
            }
        }
        
       return resultDic
        }catch{
           return nil
        }
    }
    
}

