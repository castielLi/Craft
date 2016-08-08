//
//  ActivityDetailModel.h
//  Craft
//
//  Created by castiel on 16/8/6.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityDetailContentModel.h"
#import "ActivityMemberItem.h"

@interface ActivityDetailModel : NSObject

@property int joinType;
@property (nonatomic,strong) ActivityDetailContentModel * activity;
@property (nonatomic,strong) NSMutableArray<ActivityMemberItem*> * activityUser;

@end
