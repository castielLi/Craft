//
//  activityItemModel.h
//  Craft
//
//  Created by castiel on 16/7/25.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "raidDetailModel.h"

@interface activityItemModel : NSObject

@property (nonatomic,strong) NSString * apName;
@property (nonatomic,strong) NSMutableArray<raidDetailModel*> * details;

@end
