//
//  raidDetailModel.h
//  Craft
//
//  Created by castiel on 16/7/25.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "raidLevels.h"

@interface raidDetailModel : NSObject

@property (nonatomic,strong) NSString * apdName;
@property (nonatomic,strong) NSString * apdVersion;
@property (nonatomic,strong) NSString * apdCode;
@property (nonatomic,strong) NSMutableArray<raidLevels*> * levels;

@end
