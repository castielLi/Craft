//
//  ActivityDetailContentModel.h
//  Craft
//
//  Created by castiel on 16/8/6.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityDetailContentModel : NSObject

@property (nonatomic,strong) NSString * activityCode;
@property (nonatomic,strong) NSString * activityId;
@property (nonatomic,strong) NSString * startDate;
@property (nonatomic,strong) NSString * endDate;
@property (nonatomic,strong) NSString * detail;
@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSString * chatId;
@property (nonatomic,strong) NSString * aplName;
@property (nonatomic,strong) NSString * apName;
@property int needCount;
@property int haveCount;

@end
