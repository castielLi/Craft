//
//  UILabel+Nova_UILabel.h
//  otplan
//
//  Created by castiel on 16/5/26.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Nova_UILabel)

-(CGSize)contentSize;

+(CGSize)contentSize:(CGFloat)width font:(UIFont*)font text:(NSString*)text;

@end
