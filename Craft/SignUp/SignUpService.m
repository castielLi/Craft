//
//  SignUpService.m
//  Craft
//
//  Created by castiel on 16/7/17.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import "SignUpService.h"

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

-(void)getAllMyActivities{
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
    NSDictionary * parameters = @{@"userId":userId,@"faction":@(factionValue)};
    
    [_restService post:@"/api/activity/my_activity" parameters:parameters
             callback:^ (ApiResult *result, id response){
                 if(result.state){
                     [self.delegate GetMyActivityDidFinish:result response:response];
                 }
             }];


}


@end