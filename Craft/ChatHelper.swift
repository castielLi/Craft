//
//  ChatHelper.swift
//  Craft
//
//  Created by castiel on 16/8/15.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

struct ChatHelper{
    
    static let searchFriendList = "Select userId,userName,IconUrl, battleAccount,markName FROM FriendList"
    
    static let searchGroupList = "Select groupId,groupName,groupIntro ,groupCode from GroupList"
    
    static func getAllFriend()->NSMutableArray{
        
        let fmdbHelper = FMDBHelper.sharedData() as! FMDBHelper
        return  fmdbHelper.DatabaseSearchValuesWithParameters(["userId","userName","IconUrl","battleAccount","markName"], query: searchFriendList, values: nil)
    }
    
    
    static func getAllGroup()->NSMutableArray{
        let fmdbHelper = FMDBHelper.sharedData() as! FMDBHelper
        return  fmdbHelper.DatabaseSearchValuesWithParameters(["groupId","groupName","groupIntro","groupCode"], query: searchGroupList, values: nil)
    }
}
