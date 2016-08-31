//
//  MsgBoxHelper.m
//  NovaiOS
//
//  Created by castiel on 16/4/19.
//  Copyright © 2016年 hecq. All rights reserved.
//

#import "MsgBoxHelper.h"
#import "CustomAlert.h"

@interface MsgBoxHelper(){
    
}
@end

@implementation MsgBoxHelper

+(void)show :(NSString*)title message:(NSString*)message{
    CustomAlert* alert = [[CustomAlert alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) type:title message:message];

    [alert show];
}

@end


