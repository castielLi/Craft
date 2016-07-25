//
//  initActivityModel.h
//  Craft
//
//  Created by castiel on 16/7/25.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "activityItemModel.h"

@interface initActivityModel : NSObject

@property (nonatomic,strong) NSString * Token;
@property (nonatomic,strong) NSMutableArray<activityItemModel*> * paltes;

@end
