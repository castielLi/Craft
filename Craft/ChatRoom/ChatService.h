//
//  ChatService.h
//  Craft
//
//  Created by castiel on 16/8/25.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ChatServiceDelegate <NSObject>

@optional
-(void)DidAddFriendFinish:(ApiResult *)result response:(id)response;

-(void)DidSearchFriendFinish:(ApiResult *)result response:(id)response;

@end

@interface ChatService : NSObject

@property (nonatomic, weak) id<ChatServiceDelegate> delegate;

-(void)AddFriend:(NSString*)friendId;

-(void)SearchAccount:(NSString*)account;

@end
