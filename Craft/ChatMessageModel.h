//
//  ChatMessageModel.h
//  Craft
//
//  Created by castiel on 16/7/20.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatMessageModel : NSObject

@property (nonatomic,strong) NSString * userName;
@property (nonatomic,strong) NSString * type;
@property (nonatomic,strong) NSString * userId;
@property (nonatomic,strong) NSString * content;

-(NSString*)currentModelToJsonString;

+(ChatMessageModel*)getModelFromDictionary:(NSDictionary*)dict;

@end
