//
//  CustomAlert.h
//  TravelGuide
//
//  Created by castiel on 16/8/30.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlert : UIView

@property (nonatomic,strong) NSString * status;

-(instancetype)initWithFrame:(CGRect)frame type:(NSString*)type message:(NSString*)message;

-(void)show;

@end
