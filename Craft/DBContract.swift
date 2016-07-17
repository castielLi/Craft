//
//  DBContract.swift
//  Craft
//
//  Created by castiel on 16/7/17.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation

struct DBContract{
    
    static let notificationTable = "CREATE TABLE IF NOT EXISTS RemindActivity(uuid text, activityid text)"
    
    static let createAccountTable = "CREATE TABLE IF NOT EXISTS User(account text, password text)";
    
    static let ProfileTable = "CREATE TABLE IF NOT EXISTS Profile(userId text, userName text , battleAccount , text)";
    
    static let createIconTable = "CREATE TABLE IF NOT EXISTS Icons(iconurl text,path text)";
}