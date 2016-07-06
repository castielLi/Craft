//
//  ApiResult.h
//  NovaiOS
//
//  Created by hecq on 16/3/13.
//  Copyright © 2016年 hecq. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ApiResult : NSObject

    
    @property BOOL state;
    @property  NSObject * data;
    @property NSString * message;
    

-(instancetype)init;

@end