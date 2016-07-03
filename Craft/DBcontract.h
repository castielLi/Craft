//
//  DBcontract.h
//  otplan
//
//  Created by castiel on 16/5/30.
//  Copyright © 2016年 castiel. All rights reserved.
//

#ifndef DBcontract_h
#define DBcontract_h


#endif /* DBcontract_h */

//
NSString * notificationTable = @"CREATE TABLE IF NOT EXISTS RemindActivity(uuid text, activityid text)";
NSString * createAccountTable = @"CREATE TABLE IF NOT EXISTS User(account text, password text)";
NSString * createProfileTable = @"CREATE TABLE IF NOT EXISTS Profile(userId text,displayname text , avator text, shippingAddressId text,storeId text ,status text)";
NSString * createIconTable = @"CREATE TABLE IF NOT EXISTS Icons(iconurl text,path text)";


//[self.instance executeUpdate:@"CREATE TABLE IF NOT EXISTS User(account text, password text)"];
//[self.instance executeUpdate:@"CREATE TABLE IF NOT EXISTS DeviceToken(devicetoken text)"];
//
//[self.instance executeUpdate:@"CREATE TABLE IF NOT EXISTS Profile(userId text,companyName text,postCode text,displayName text)"];