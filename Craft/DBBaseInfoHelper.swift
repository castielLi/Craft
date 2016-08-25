//
//  DBBaseInfoHelper.swift
//  Craft
//
//  Created by castiel on 16/8/25.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class DBBaseInfoHelper{
    static let getCurrentUserId = "select userid ,userName from Profile"

    static func GetCurrentUserInfo()->NSArray?{
        let _dbHelper = FMDBHelper.sharedData() as! FMDBHelper
        let values = _dbHelper.DatabaseQueryWithParameters(["userid","userName"], query: getCurrentUserId, values: nil)
        as? NSDictionary
        
        if(values != nil){
            let array = NSMutableArray()
            array.addObject(values!.valueForKey("userid") as! String)
            array.addObject(values!.valueForKey("userName") as! String)
            return array
        }
        return nil
    }
}
