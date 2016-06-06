//
//  RCIMHelper.m
//  Craft
//
//  Created by castiel on 16/6/4.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import "RCIMHelper.h"
#import <RongIMLib/RongIMLib.h>


@implementation RCIMHelper

+(NSArray*)RetrunConversationList{
    NSArray *conversationList = [[RCIMClient sharedRCIMClient]
                                 getConversationList:@[@(ConversationType_PRIVATE),
                                                       @(ConversationType_DISCUSSION),
                                                       @(ConversationType_GROUP),
                                                       @(ConversationType_SYSTEM),
                                                       @(ConversationType_APPSERVICE),
                                                       @(ConversationType_PUBLICSERVICE)]];
    return conversationList;
}

@end
