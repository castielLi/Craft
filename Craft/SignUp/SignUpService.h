//
//  SignUpService.h
//  Craft
//
//  Created by castiel on 16/7/17.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SignUpServiceDelegate <NSObject>

@optional
-(void)GetMyActivityDidFinish:(ApiResult *)result response:(id)response;

-(void)GetActivityDetailFinish:(ApiResult *)result response:(id)response activityId:(NSString*)activityId;

-(void)GetApplylistDidFinish:(ApiResult *)result response:(id)response;

-(void)DealApplyRequestFinish:(ApiResult *)result response:(id)response index:(NSString*)index;

@end

@interface SignUpService: NSObject

@property (nonatomic, weak) id<SignUpServiceDelegate> delegate;

-(instancetype)init;

-(void)getAllMyActivities:(NSString*)pageNum;

-(void)searchActivityies:(NSString*)Content pageNum:(NSString*)pageNum;

-(void)getAllActivities:(NSString*)pageNum;

-(void)getActivityDetail:(NSString*)activityId;

-(void)getApplyList:(NSString*)activityId;

-(void)applyRequest:(NSString*)activityId requestUserId:(NSString*)userId index:(NSString*)index;

-(void)refuseRequest:(NSString*)activityId requestUserId:(NSString*)userId index:(NSString*)index;

@end