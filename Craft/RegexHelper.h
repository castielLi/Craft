//
//  RegexHelper.h
//  NovaiOS
//
//  Created by castiel on 16/4/27.
//  Copyright © 2016年 hecq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegexHelper : NSObject

@property (nonatomic,strong)NSRegularExpression * regex;

-(instancetype)initWithPattern:(NSString*)pattern;

-(BOOL)match:(NSString*)input;
@end
