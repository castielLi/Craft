//
//  ChatService.m
//  Craft
//
//  Created by castiel on 16/8/25.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import "ChatService.h"

@interface ChatService ()
{
    RestService * _restService;
    
    FMDBHelper * _dbHelper;
}
@end

@implementation ChatService

@synthesize delegate = _delegate;

-(instancetype) init{
    
    self = [super init];
    _restService = [[RestService alloc]init];
    
    _dbHelper = [FMDBHelper sharedData];
    
    return self;
}

-(void)AddFriend:(NSString *)friendId{
    NSString * currentUserId = @"";
    NSDictionary * profileValues = [_dbHelper DatabaseQueryWithParameters:@[@"userid"] query:@"select userid from Profile" values:nil];
    if (profileValues != nil){
        currentUserId = [profileValues valueForKey:@"userid"];
    }
    
    
    NSDictionary * parameters = @{@"userId":currentUserId,@"friendId":friendId,@"friendRemarkName":@""};
    
    [_restService post:@"/user/chat/add_friend" parameters:parameters
              callback:^ (ApiResult *result, id response){
                  [self.delegate DidAddFriendFinish:result response:response];
              }];
}

@end