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


@end