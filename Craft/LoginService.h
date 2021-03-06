//
//  LoginService.h
//  NovaiOS
//
//  Created by hecq on 16/3/31.
//  Copyright © 2016年 hecq. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "ApiResult.h"
#import "FMDBHelper.h"
#import "RestService.h"

@protocol LoginServiceDelegate <NSObject>

@optional
-(void)loginDidFinish:(ApiResult *)result response:(id)response;

-(void)registerDidFinish:(ApiResult *)result response:(id)response;

@end

@interface LoginService: NSObject

@property (nonatomic, weak) id<LoginServiceDelegate> delegate;

-(void)login:(NSString *)username password:(NSString *)password;

-(void)GetMyFriends;

-(void)GetMyGroups;

-(void)GetInitActivitiesData;

-(void)Register:(NSString*)battleAccount nick:(NSString*)nick password:(NSString*)password telphone:(NSString*)
telphone;


@end

