//
//  SignUpService.m
//  Craft
//
//  Created by castiel on 16/7/17.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import "SignUpService.h"
#import "ActivityItemModel.h"
#import "ActivityDetailModel.h"

@interface SignUpService ()
{
    RestService * _restService;
    
    FMDBHelper * _dbHelper;
}
@end

@implementation SignUpService

@synthesize delegate = _delegate;

-(instancetype) init{
    
    self = [super init];
    _restService = [[RestService alloc]init];
    
    _dbHelper = [FMDBHelper sharedData];
    
    return self;
}

-(void)getAllMyActivities:(NSString*)pageNum{
    NSString * faction = @"";
    NSString * userId = @"";
    NSDictionary * profileValues = [_dbHelper DatabaseQueryWithParameters:@[@"userid"] query:@"select userid from Profile" values:nil];
    if (profileValues != nil){
        userId = [profileValues valueForKey:@"userid"];
    }
    
    NSDictionary * factionValues = [_dbHelper DatabaseQueryWithParameters:@[@"faction"] query:@"select faction from Faction" values:nil];
    if (factionValues != nil){
        faction = [factionValues valueForKey:@"faction"];
    }
    
    NSInteger factionValue = [faction integerValue];
    NSDictionary * parameters = @{@"userId":userId,@"faction":@(factionValue),@"pageNum":pageNum};
    
    [_restService post:@"/api/activity/my_activity" parameters:parameters
             callback:^ (ApiResult *result, id response){
                 if(result.state){
                     
                     NSMutableArray * array = [[NSMutableArray alloc]init];
                     for(int i= 0; i<((NSArray *)response).count; i++){
                         ActivityItemModel * model = [ActivityItemModel mj_objectWithKeyValues:((NSArray *)response)[i]];
                         [array addObject:model];
                     }
                     
                     result.data = array;

                     [self.delegate GetMyActivityDidFinish:result response:response];
                 }else{
                   [self.delegate GetMyActivityDidFinish:result response:response];
                 }
             }];


}

-(void)getAllActivities:(NSString*)pageNum{
    NSString * faction = @"";
    NSString * userId = @"";
    NSDictionary * profileValues = [_dbHelper DatabaseQueryWithParameters:@[@"userid"] query:@"select userid from Profile" values:nil];
    if (profileValues != nil){
        userId = [profileValues valueForKey:@"userid"];
    }
    
    NSDictionary * factionValues = [_dbHelper DatabaseQueryWithParameters:@[@"faction"] query:@"select faction from Faction" values:nil];
    if (factionValues != nil){
        faction = [factionValues valueForKey:@"faction"];
    }
    
    NSInteger factionValue = [faction integerValue];
    NSDictionary * parameters = @{@"userId":userId,@"faction":@(factionValue),@"pageNum":pageNum};
    
    [_restService post:@"/api/activity/get_all_activity" parameters:parameters
              callback:^ (ApiResult *result, id response){
                  if(result.state){
                      
                      NSMutableArray * array = [[NSMutableArray alloc]init];
                      for(int i= 0; i<((NSArray *)response).count; i++){
                          ActivityItemModel * model = [ActivityItemModel mj_objectWithKeyValues:((NSArray *)response)[i]];
                          [array addObject:model];
                      }
                      
                      result.data = array;
                      
                      [self.delegate GetMyActivityDidFinish:result response:response];
                  }else{
                     [self.delegate GetMyActivityDidFinish:result response:response];
                  }
              }];
}

-(void)getActivityDetail:(NSString*)activityId{
    NSString * userId = @"";
    NSDictionary * profileValues = [_dbHelper DatabaseQueryWithParameters:@[@"userid"] query:@"select userid from Profile" values:nil];
    if (profileValues != nil){
        userId = [profileValues valueForKey:@"userid"];
    }
    
    NSString * url = [NSString stringWithFormat:@"/api/activity/activity_detail?activityId=%@&userId=%@",activityId,userId];
    
    [_restService get:url parameters:nil
              callback:^ (ApiResult *result, id response){
                  if(result.state){
                      
                     
                    ActivityDetailModel * data = [ActivityDetailModel mj_objectWithKeyValues: response];
                    result.data = data;
                    [self.delegate GetActivityDetailFinish:result response:response activityId:activityId];
                  }else{
                     [self.delegate GetActivityDetailFinish:result response:response activityId:activityId];
                  }
              }];
}


-(void)getApplyList:(NSString*)activityId{
    
    NSString * url = [NSString stringWithFormat:@"/api/activity/get_request_list?activityId=%@",activityId];
    
    [_restService get:url parameters:nil
             callback:^ (ApiResult *result, id response){
                 if(result.state){
                     NSMutableArray * array = [[NSMutableArray alloc]init];
                     for(int i= 0; i<((NSArray *)response).count; i++){
                         ActivityItemModel * model = [ActivityItemModel mj_objectWithKeyValues:((NSArray *)response)[i]];
                         [array addObject:model];
                     }
                     
                     result.data = array;
                     [self.delegate GetApplylistDidFinish:result response:response];
                 }else{
                     [self.delegate GetApplylistDidFinish:result response:response];
                 }
             }];

}

-(void)searchActivityies:(NSString*)Content pageNum:(NSString*)pageNum;{
    NSString * faction = @"";

    NSDictionary * factionValues = [_dbHelper DatabaseQueryWithParameters:@[@"faction"] query:@"select faction from Faction" values:nil];
    if (factionValues != nil){
        faction = [factionValues valueForKey:@"faction"];
    }
    
    NSInteger factionValue = [faction integerValue];
    NSDictionary * parameters = @{@"content":Content,@"faction":@(factionValue),@"pageNum":pageNum};
    
    [_restService post:@"/api/activity/activity_search" parameters:parameters
              callback:^ (ApiResult *result, id response){
                  if(result.state){
                      
                      NSMutableArray * array = [[NSMutableArray alloc]init];
                      for(int i= 0; i<((NSArray *)response).count; i++){
                          ActivityItemModel * model = [ActivityItemModel mj_objectWithKeyValues:((NSArray *)response)[i]];
                          [array addObject:model];
                      }
                      
                      result.data = array;
                      
                      [self.delegate GetMyActivityDidFinish:result response:response];
                  }else{
                      [self.delegate GetMyActivityDidFinish:result response:response];
                  }
              }];
}

@end