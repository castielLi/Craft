//
//  DutyResponseView.m
//  Craft
//
//  Created by castiel on 16/8/13.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import "DutyResponseView.h"

@interface DutyResponseView(){
    UIImageView * mainView;
    UIPickerView * firstPicker;
    UIPickerView * secondPicker;
    UITapGestureRecognizer * blankTap;
    UIImageView * displayImage;
    UIView * contentView;
}
@end

@implementation DutyResponseView

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    [self registerEvent];
    
    self.firstRollData = [[NSMutableArray alloc]initWithObjects:@"tank",@"heal",@"damage",@"damage", nil];
    
    self.secondRollData = [[NSMutableArray alloc]initWithObjects:@{@"perfressId":@"1",@"image":@"zs"},@{@"perfressId":@"2",@"image":@"qs"},@{@"perfressId":@"3",@"image":@"dk"},@{@"perfressId":@"6",@"image":@"d"}, @{@"perfressId":@"8",@"image":@"ws"},@{@"perfressId":@"9",@"image":@"dh"},nil];
    
    [self initView];
    // Do any additional setup after loading the view.
}

-(void)initView{
    
    mainView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 280) / 2, (self.view.frame.size.height - 240)/2, 280, 240)];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"selectedBackground" ofType:@"png"];
    mainView.image = [UIImage imageWithContentsOfFile:path];
    mainView.alpha = 1;
    
    mainView.backgroundColor = [UIColor clearColor];
    mainView.layer.cornerRadius = 10;
    mainView.layer.masksToBounds = true;
    [[self view]addSubview:mainView];
    
    
    firstPicker = [[UIPickerView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 280) / 2, (self.view.frame.size.height - 240)/2, 140, 240)];
    [[self view]addSubview:firstPicker];
    firstPicker.delegate = self;
    firstPicker.dataSource = self;
    firstPicker.tag = 1;
    
    
    secondPicker = [[UIPickerView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 280) / 2 + 140, (self.view.frame.size.height - 240)/2, 140, 240)];
    [[self view]addSubview:secondPicker];
    secondPicker.delegate = self;
    secondPicker.dataSource = self;
    secondPicker.tag = 2;
    
    self.perfressType = self.firstRollData[0];
    self.perfressId = [self.secondRollData[0] valueForKey:@"perfressId"];
}

-(void)CancelClick:(UIButton*)sender{
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)registerEvent{
    blankTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(blankClick:)];
    blankTap.numberOfTapsRequired = 1;
    [[self view]addGestureRecognizer:blankTap];
}

-(void)blankClick:(UITapGestureRecognizer *) sender {
    self.Block();
    [self dismissViewControllerAnimated:true completion:nil];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    CGPoint point = [touch locationInView:gestureRecognizer.view];
    if (CGRectContainsPoint(mainView.frame, point)){
        return false;
    }
    return true;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag == 1){
        return self.firstRollData.count;
    }
    return self.secondRollData.count;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 140, 60)];
    displayImage = [[UIImageView alloc]initWithFrame:CGRectMake(70, 5, 50, 50)];
    [contentView addSubview:displayImage];
    if(pickerView.tag == 1){
    
    displayImage.image = [UIImage imageNamed:self.firstRollData[row]];
    
    }else{
        [displayImage setFrame:CGRectMake(30, 5, 50, 50)];
        displayImage.image = [UIImage imageNamed:  [self.secondRollData[row] valueForKey:@"image"]];
    }
    return contentView;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView.tag == 1){
        self.perfressType = [NSString stringWithFormat:@"%li",(long)row];
        
        [self.secondRollData removeAllObjects];
        if([self.perfressType isEqualToString:@"0"]){
            self.secondRollData = [[NSMutableArray alloc]initWithObjects:@{@"perfressId":@"1",@"image":@"zs"},@{@"perfressId":@"2",@"image":@"qs"},@{@"perfressId":@"3",@"image":@"dk"},@{@"perfressId":@"6",@"image":@"d"}, @{@"perfressId":@"8",@"image":@"ws"},@{@"perfressId":@"9",@"image":@"dk"},nil];
        }else if([self.perfressType isEqualToString:@"1"]){
           self.secondRollData = [[NSMutableArray alloc]initWithObjects:@{@"perfressId":@"2",@"image":@"qs"},@{@"perfressId":@"4",@"image":@"sm"},@{@"perfressId":@"8",@"image":@"ws"},@{@"perfressId":@"11",@"image":@"ms"}, @{@"perfressId":@"6",@"image":@"d"},nil];
        }else if([self.perfressType isEqualToString:@"2"]){
            self.secondRollData = [[NSMutableArray alloc]initWithObjects:@{@"perfressId":@"1",@"image":@"zs"},@{@"perfressId":@"2",@"image":@"qs"},@{@"perfressId":@"3",@"image":@"dk"},@{@"perfressId":@"4",@"image":@"sm"}, @{@"perfressId":@"7",@"image":@"dz"},@{@"perfressId":@"9",@"image":@"dh"},@{@"perfressId":@"6",@"image":@"d"},@{@"perfressId":@"8",@"image":@"ws"},nil];
        }else{
            self.secondRollData = [[NSMutableArray alloc]initWithObjects:@{@"perfressId":@"4",@"image":@"sm"},@{@"perfressId":@"5",@"image":@"lr"},@{@"perfressId":@"10",@"image":@"fs"},@{@"perfressId":@"11",@"image":@"ms"}, @{@"perfressId":@"12",@"image":@"ss"},@{@"perfressId":@"6",@"image":@"d"},nil];
        }
        [secondPicker reloadAllComponents];
    }
    else{
        self.perfressId = [self.secondRollData[row] valueForKey:@"perfressId"];
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 60;
}


@end
