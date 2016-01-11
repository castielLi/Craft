//
//  SendNotification.swift
//  Craft
//
//  Created by castiel on 16/1/8.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation

struct SendNotification {
    
    static let ITEMS_KEY = "SignNotification"
    
    static func SendLocalNotifation(note : SignLocalNotification){
//        var todoDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) ?? Dictionary() // if todoItems hasn't been set in user defaults, initialize todoDictionary to an empty dictionary using nil-coalescing operator (??)
//        
//        todoDictionary[note.UUID!] = ["deadline": note.deadLine!, "title": note.title!, "UUID": note.UUID! ] // store NSData representation of todo item in dictionary with UUID as key
//        NSUserDefaults.standardUserDefaults().setObject(todoDictionary, forKey: ITEMS_KEY) // save/overwrite todo item list
        
        // create a corresponding local notification
        let notification = UILocalNotification()
        notification.alertBody = "Todo Item \"\(note.title!)\" Is Overdue" // text that will be displayed in the notification
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = note.deadLine!
        // todo item due date (when notification will be fired)
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["UUID": note.UUID!, ] // assign a unique identifier to the notification so that we can retrieve it later
        notification.category = "TODO_CATEGORY"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
}