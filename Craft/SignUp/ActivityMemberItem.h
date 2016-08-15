//
//  ActivityMemberItem.h
//  Craft
//
//  Created by castiel on 16/8/6.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityMemberItem : NSObject

@property (nonatomic,strong) NSString * userId;
@property (nonatomic,strong) NSString * userName;
@property (nonatomic,strong) NSString * email;
@property int joinType;
@property (nonatomic,strong) NSString * headPic;
@property int professionType;
@property int professionId;
@property (nonatomic,strong) NSString * content;
@property int jifen;

@end
