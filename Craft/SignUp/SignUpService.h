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

@end

@interface SignUpService: NSObject

@property (nonatomic, weak) id<SignUpServiceDelegate> delegate;

-(instancetype)init;

-(void)getAllMyActivities;

@end