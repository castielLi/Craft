//
//  ChatMessageModel.m
//  Craft
//
//  Created by castiel on 16/7/20.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import "ChatMessageModel.h"

@implementation ChatMessageModel

-(NSString*)currentModelToJsonString{
    NSDictionary * chatDic = self.mj_keyValues;
    
    NSError *error;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:chatDic options:NSJSONWritingPrettyPrinted error:&error];
     return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

-(ChatMessageModel*)getModelFromDictionary:(NSDictionary*)dict{
    ChatMessageModel * model = [ChatMessageModel mj_objectWithKeyValues:dict];
    return model;
}

@end
