//
//  MsgBoxHelper.m
//  NovaiOS
//
//  Created by castiel on 16/4/19.
//  Copyright © 2016年 hecq. All rights reserved.
//

#import "MsgBoxHelper.h"

@interface MsgBoxHelper(){
    
}
@end

@implementation MsgBoxHelper

+(void)show :(NSString*)title message:(NSString*)message{
    UIAlertView* alert = [[UIAlertView alloc]init];
    alert.message = message;
    alert.title = title;
    [alert addButtonWithTitle:@"OK"];
    [alert show];
}

@end


