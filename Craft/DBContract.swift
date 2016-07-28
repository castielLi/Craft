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
    
    static let createRaidTypeName = "CREATE TABLE IF NOT EXISTS RaidType(apName text,apCode text)";
    
    static let createRaid = "CREATE TABLE IF NOT EXISTS Raid(apdName text,apdCode text,typeCode text)";
    
    static let createRaidLevel = "CREATE TABLE IF NOT EXISTS RaidLevel(aplName text,aplCode text,raidCode text)";
    
    static let createInitDataToken = "CREATE TABLE IF NOT EXISTS InitActivityToken(token text)";
    
    static let createFriendTable = "CREATE TABLE IF NOT EXISTS FriendList(userId text,userName text,IconUrl text, battleAccount text, markName text)";
}