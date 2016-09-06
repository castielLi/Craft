//
//  NearActivityModel.h
//  Craft
//
//  Created by castiel on 16/9/6.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearActivityModel : NSObject

@property int haveTankCount;
@property int profressionTyep;
@property int profressionId;
@property (nonatomic,strong) NSString * chatId;
@property int haveDPSCount;
@property double endDate;
@property (nonatomic,strong) NSString * createUserName;
@property (nonatomic,strong) NSString * activity_code;
@property (nonatomic,strong) NSString * title;
@property int haveHealCount;
@property (nonatomic,strong) NSString * activityId;
@property (nonatomic,strong) NSString * groupId;
@property (nonatomic,strong) NSString * aplName;
@property (nonatomic,strong) NSString * detail;
@property double startDate;
@property double createDate;

@end
