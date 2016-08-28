//
//  ChatService.m
//  Craft
//
//  Created by castiel on 16/8/25.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import "ChatService.h"
#import "UserInfoModel.h"

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

-(void)SearchAccount:(NSString*)account{
    
    NSString * url = [NSString stringWithFormat:@"/user/chat/search_friend?battleUrl=%@",account];
    
    [_restService get:url parameters:nil
              callback:^ (ApiResult *result, id response){
                  
                  if(result.state){
                      if (((NSArray*)response).count > 0){
                      
                      UserInfoModel * model = [UserInfoModel mj_objectWithKeyValues:response[0]];
                      result.data = model;
                      }else{
                          result.data = nil;
                      }
                     [self.delegate DidSearchFriendFinish:result response:response];
                  }else{
                      [self.delegate DidSearchFriendFinish:result response:response];
                  }
                  
              }];

}


@end