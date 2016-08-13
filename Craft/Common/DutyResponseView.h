//
//  DutyResponseView.h
//  Craft
//
//  Created by castiel on 16/8/13.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DutyResponseView : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong) NSString * perfressType;
@property (nonatomic,strong) NSString * perfressId;

@property (nonatomic,copy)void(^Block)();

@property (nonatomic,strong) NSMutableArray* firstRollData;
@property (nonatomic,strong) NSMutableArray* secondRollData;

@end
