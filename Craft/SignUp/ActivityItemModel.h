//
//  ActivityItemModel.h
//  Craft
//
//  Created by castiel on 16/7/28.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityItemModel : NSObject

@property (nonatomic,strong) NSString * activityId;
@property (nonatomic,strong) NSString * detail;
@property (nonatomic,strong) NSString * aplName;
@property (nonatomic,strong) NSString * createUserName;

@property int professionType;
@property (nonatomic,strong) NSString * chatId;
@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSString * activity_code;

@property int needDPSCount;
@property int haveDPSCount;
@property int needTankCount;
@property int haveTankCount;
@property int needHealCount;
@property int haveHealCount;

@property (nonatomic,strong) NSString * startDate;
@property (nonatomic,strong) NSString * endDate;

@end
