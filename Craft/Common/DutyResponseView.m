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
    [self initView];
    [self registerEvent];
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
    displayImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140, 240)];
    return displayImage;
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag == 1){
        return _firstRollData[row];
    }
    return _secondRollData[row];
};

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView.tag == 1){
       
    }
    else{
        
    }
}


@end
