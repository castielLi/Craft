//
//  OneRollSelection.h
//  NovaiOS
//
//  Created by castiel on 16/4/8.
//  Copyright © 2016年 hecq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneRollSelection : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource , UIGestureRecognizerDelegate>

@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,strong) NSString * displayKey;
@property (nonatomic,strong) NSString * valueKey;

@property (nonatomic,copy)void(^Block)();
@property (nonatomic,strong) NSString * value;
@property (nonatomic,strong) NSString * key;

@property BOOL isNotify;

@end
