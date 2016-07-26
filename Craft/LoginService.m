//
//  LoginService.m
//  NovaiOS
//
//  Created by hecq on 16/3/31.
//  Copyright © 2016年 hecq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginService.h"
#import <MJExtension/MJExtension.h>
#import "ProfileModel.h"
#import "initActivityModel.h"


@interface LoginService ()
{
    RestService * _restService;
    
    FMDBHelper * _dbHelper;
}



@end


@implementation LoginService

@synthesize delegate = _delegate;

-(instancetype) init{
    
    self = [super init];
    _restService = [[RestService alloc]init];
    
    _dbHelper = [FMDBHelper sharedData];
    
    return self;
}

-(void) login:(NSString *)username password:(NSString *)password
{
    NSDictionary * parameter = @{@"userName":username,@"password":password};
    
    [_restService post:@"/api/common/login" parameters:parameter
              callback:^ (ApiResult *result, id response){
                  if(result.state){
                 if(_delegate != nil)
                 {
                     
                     ProfileModel * profile = [ProfileModel mj_objectWithKeyValues:response];
                     profile.battleAccount = @"853757935@qq.com";
                     [_dbHelper DatabaseExecuteWithQuery:@"delete from Profile" values:nil];
                     if ([_dbHelper DatabaseExecuteWithQuery:@"insert into Profile (userid,userName,battleAccount) values (?,?,?)" values:@[profile.userId,profile.userName,@""]]){
                         NSLog(@"insert profile success");
                     }else{
                         NSLog(@"insert profile failed");
                     }
                
                     [_dbHelper DatabaseExecuteWithQuery:@"delete from User" values:nil];
                     if ([_dbHelper DatabaseExecuteWithQuery:@"insert into User (account,password) values (?,?)" values:@[username,password]]){
                         NSLog(@"insert user success");
                     }else{
                         NSLog(@"insert user failed");
                     }

                     
                     [_delegate loginDidFinish:result response:response];
                     }
                  }else{
                     [_delegate loginDidFinish:result response:response];
                  }
                }];

}

-(void)GetMyFriends
{
    NSString * userId;
    NSDictionary * values = [_dbHelper DatabaseQueryWithParameters:@[@"userid"] query:@"select userid from Profile" values:nil];
    if (values != nil){
        userId = [values valueForKey:@"userid"];
    }
    
    NSString * url = [NSString stringWithFormat:@"/user/chat/get_friends?userId=%@",userId];
    
    [_restService get:url parameters:nil
             callback:^ (ApiResult *result, id response){
                 if(result.state){
                     
                         //                         NSMutableArray * array = [[NSMutableArray alloc]init];
                         //                         for(int i= 0; i<((NSArray *)response).count; i++){
                         //                             [array addObject:((NSArray *)response)[i]];
                         //                         }
                         //
                         //                         result.data = array;
                     
                 }
             }];
    
}

-(void)GetMyGroups{
    NSString * userId;
    NSDictionary * values = [_dbHelper DatabaseQueryWithParameters:@[@"userid"] query:@"select userid from Profile" values:nil];
    if (values != nil){
        userId = [values valueForKey:@"userid"];
    }
    
    NSString * url = [NSString stringWithFormat:@"/user/chat/get_user_group?userId=%@",userId];
    
    [_restService get:url parameters:nil
             callback:^ (ApiResult *result, id response){
                 if(result.state){
                     
                     //                         NSMutableArray * array = [[NSMutableArray alloc]init];
                     //                         for(int i= 0; i<((NSArray *)response).count; i++){
                     //                             [array addObject:((NSArray *)response)[i]];
                     //                         }
                     //
                     //                         result.data = array;
                     
                 }
             }];
}

-(void)GetInitActivitiesData{
    
    NSDictionary * parameters = @{@"newToken":@"1111"};
    
    [_restService post:@"/api/activity/init_activity_create" parameters:parameters
              callback:^ (ApiResult *result, id response){
                  if(result.state){
                      if(_delegate != nil)
                      {
                          
                          initActivityModel * model = [initActivityModel mj_objectWithKeyValues:response];
                          [_dbHelper DatabaseExecuteWithQuery:@"delete from RaidType" values:nil];
                          [_dbHelper DatabaseExecuteWithQuery:@"delete from createRaidLevel" values:nil];
                          [_dbHelper DatabaseExecuteWithQuery:@"delete from Raid" values:nil];
                          for(activityItemModel* item in model.paltes){
                              
                              if ([_dbHelper DatabaseExecuteWithQuery:@"insert into RaidType (apName,apCode) values (?,?)" values:@[item.apName,item.apCode]]){
                                  NSLog(@"insert RaidType success");
                              }else{
                                  NSLog(@"insert RaidType failed");
                              }
                              
                              for(raidDetailModel * raid in item.details){
                              
                                  if(raid.levels.count > 0){
                                      for(raidLevels* level in raid.levels){
                                      
                                      if ([_dbHelper DatabaseExecuteWithQuery:@"insert into createRaidLevel (aplName,aplCode,raidCode) values (?,?,?)" values:@[level.aplName,level.aplCode,raid.apdCode]]){
                                          NSLog(@"insert createRaidLevel success");
                                      }else{
                                          NSLog(@"insert createRaidLevel failed");
                                      }
                                    }
                                  }
                                  
                                  
                                 
                                 if ([_dbHelper DatabaseExecuteWithQuery:@"insert into Raid (apdName,apdCode,typeCode) values (?,?,?)" values:@[raid.apdName,raid.apdCode,item.apCode]]){
                                     NSLog(@"insert Raid success");
                                 }else{
                                     NSLog(@"insert Raid failed");
                                 }
                              }
                          }
                      }
                  }
              }];

}


@end