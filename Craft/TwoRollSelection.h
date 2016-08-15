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

@property (nonatomic,strong) NSMutableArray* firstRollData;
@property (nonatomic,strong) NSMutableArray* secondRollData;

@property (nonatomic,strong) NSString * currentYear;
@property (nonatomic,strong) NSString * currentMonth;
@property (nonatomic,strong) NSString * currentDay;
@property (nonatomic,strong) NSString * currentHour;
@property (nonatomic,strong) NSString * currentMinute;
@property (nonatomic,strong) NSString * date;

@property (nonatomic,strong) NSString * year;
@property (nonatomic,strong) NSString* month;
@property (nonatomic,strong) NSString* day;

@property (nonatomic,strong) NSString * beginHour;
@property (nonatomic,strong) NSString * beginMinute;

@property (nonatomic,strong) NSString * endHour;
@property (nonatomic,strong) NSString * endMinute;

@property (nonatomic,copy)void(^Block)();

@end
