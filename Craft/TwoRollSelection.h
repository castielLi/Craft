//
//  TwoRollSelection.h
//  NovaiOS
//
//  Created by castiel on 16/4/14.
//  Copyright © 2016年 hecq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColorHelper.h"

@interface TwoRollSelection : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource , UIGestureRecognizerDelegate>

@property (nonatomic,strong) NSArray* firstRollData;
@property (nonatomic,strong) NSArray* secondRollData;

@property (nonatomic,strong) NSString* month;
@property (nonatomic,strong) NSString* year;

@property (nonatomic,copy)void(^Block)();

@end
