//
//  CustomAlert.m
//  TravelGuide
//
//  Created by castiel on 16/8/30.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import "CustomAlert.h"

@interface CustomAlert (){
   
    UIImageView * backImage;
    UIImageView * statusImage;
    UILabel * infoContent;
    UIButton * confirmButton;
    UIView * backgroundView;
    UITapGestureRecognizer * tap;
}
@end

@implementation CustomAlert


-(instancetype)initWithFrame:(CGRect)frame type:(NSString*)type message:(NSString*)message{

    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    
    backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0.3;
    [self addSubview:backgroundView];

    
    backImage = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - 310) / 2, (self.frame.size.height - 250) / 2, 310, 175)];

    backImage.image = [UIImage imageNamed:@"alertBackground"];
    [self addSubview:backImage];
    
    
    statusImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 - 18, (self.frame.size.height - 250) / 2 + 26, 36, 36)];
    
    [self addSubview:statusImage];
    
    if([type isEqualToString: @"错误"]){
        statusImage.image = [UIImage imageNamed:@"failed"];
    }else if([type isEqualToString:@"成功"]){
         statusImage.image = [UIImage imageNamed:@"success"];
    }else{
         statusImage.image = [UIImage imageNamed:@"info"];
    }
    
    infoContent = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 - 100, (self.frame.size.height - 250) / 2 + 26 + 50, 200, 32)];
    infoContent.font = [UIFont fontWithName:@"KaiTi" size:16];
    infoContent.numberOfLines = 2;
    infoContent.textAlignment = NSTextAlignmentCenter;
    infoContent.textColor = [UIColor whiteColor];
    infoContent.text = message;
    [self addSubview:infoContent];
    
    confirmButton = [[UIButton alloc]initWithFrame:CGRectMake( backImage.frame.origin.x + 100 , backImage.frame.origin.y + 175 - 37, 100, 26)];
    [self addSubview:confirmButton];
    [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"confirm"] forState:UIControlStateNormal];
    return self;
}

-(void)confirmButtonClick:(UIButton*)sender{

    [self removeFromSuperview];
}

-(void)show{
    UIWindow * window = (UIWindow*)[UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
