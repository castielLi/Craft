//
//  RegexHelper.m
//  NovaiOS
//
//  Created by castiel on 16/4/27.
//  Copyright © 2016年 hecq. All rights reserved.
//

#import "RegexHelper.h"

@implementation RegexHelper

-(instancetype)initWithPattern:(NSString *)pattern{

    NSError * error = [[NSError alloc]init];
    self.regex = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    return self;
}

-(BOOL)match:(NSString*)input{
    NSArray * result = [self.regex matchesInString:input options:nil range:NSMakeRange(0, input.length)];
    if (result.count>0){
        return true;
    }else{
    return false;
    }
}

@end
