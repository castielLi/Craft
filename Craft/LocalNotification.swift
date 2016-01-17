//
//  SignLocalNotification.swift
//  Craft
//
//  Created by castiel on 16/1/8.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation

class LocalNotification{
    var title : String?
    var deadLine : NSDate?
    var UUID : String?
    
    init(){}
    
    convenience init(title : String , deadLine : NSDate){
        self.init()
        self.title = title
        self.deadLine = deadLine
        self.UUID = NSUUID().UUIDString
    }
}