//
//  SendNotification.swift
//  Craft
//
//  Created by castiel on 16/1/8.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation

struct NotificationSql{
   
    static let addNewActivitySql = "insert into RemindActivity (uuid, activityid ) values (?, ?)";

    static let deleteActivitySqlById = "delete from RemindActivity where activityid = ?";
    
    static let searchActivitySqlById = "select uuid from RemindActivity where activityid = ?";
}

struct SendNotification {
    
    static let ITEMS_KEY = "SignNotification"
    
    
    
    static func SendLocalNotifation(note : LocalNotification){

        let notification = UILocalNotification()
        
        let dbHelper = FMDBHelper.sharedData()
        
        notification.alertBody = "你参与的活动\"\(note.title!)\"已经开始了，赶快加入活动吧！" // text that will be displayed in the notification
        notification.alertAction = "打开" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        
        notification.applicationIconBadgeNumber = 1;
        
        notification.hasAction = true
        notification.fireDate = note.deadLine!
        // todo item due date (when notification will be fired)
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["UUID": note.UUID!, ] // assign a unique identifier to the notification so that we can retrieve it later
        notification.category = "Notification_Category"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        

          dbHelper.DatabaseExecuteWithQuery(NotificationSql.addNewActivitySql, values: [note.UUID!,"\(note.activityId!)"])
    }
    
    
    static func RemoveNotificationFromUUID(activityId : Int){
        let dbHelper = FMDBHelper.sharedData()
        
        let app:UIApplication = UIApplication.sharedApplication()

        let values = dbHelper.DatabaseQueryWithParameters(["uuid"], query: NotificationSql.searchActivitySqlById, values: ["\(activityId)"]) as NSDictionary
        
        let uuid = values.valueForKey("uuid")
        if uuid != nil{
        for oneEvent in app.scheduledLocalNotifications! {
            let notification = oneEvent as UILocalNotification
            let userInfoCurrent = notification.userInfo! as! [String:AnyObject]
            let uid = userInfoCurrent["UUID"]! as! String
            if uid == uuid as! String{
                //Cancelling local notification
                app.cancelLocalNotification(notification)
                break;
            }
        }
         let success = dbHelper.DatabaseExecuteWithQuery(NotificationSql.deleteActivitySqlById,values: ["\(activityId)"])
            if success {
               print("delete local notification success")
            }else{
               print("delete local notification failed")
            }
        }
    }
}