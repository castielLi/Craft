//
//  TwoRollSelection.m
//  NovaiOS
//
//  Created by castiel on 16/4/14.
//  Copyright © 2016年 hecq. All rights reserved.
//

#import "TwoRollSelection.h"
#import "UIColorHelper.h"
#import "PlaySound.h"
@import AVFoundation;

@interface TwoRollSelection (){
    UIImageView * mainView;
    UIPickerView * firstPicker;
    UIPickerView * secondPicker;
    UITapGestureRecognizer * blankTap;
    
    UIImageView * leftView;
    UIImageView * rightView;
    
    UISwipeGestureRecognizer * leftSwipe;
    UISwipeGestureRecognizer * rightSwipe;
    NSInteger index;
    UILabel * displaylabel;
    
    PlaySound * sound;
    
    NSArray * hoursDataSource;
    NSArray * minutesDataSource;
    
    UILabel * titleLabel;
    UIButton * confirmButton;
    
}

@end
@implementation TwoRollSelection

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self initView];
    [self registerEvent];
    
    sound = [PlaySound sharedData];
    
    minutesDataSource = [[NSArray alloc]initWithObjects:@"00",@"05",@"10",@"15",@"20",@"25",@"30",@"35",@"40",@"45",@"50",@"55",nil];
    
    hoursDataSource = [[NSArray alloc]initWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23" ,nil];
    
    
    index = 1;
    // Do any additional setup after loading the view.
}

-(void)initView{
    
    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height - 240)/2 - 45, self.view.frame.size.width, 28)];
    titleLabel.font = [UIFont fontWithName:@"KaiTi" size:28];
    titleLabel.text = @"活动日期";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    mainView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 240) / 2, (self.view.frame.size.height - 240)/2, 240, 240)];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"selectedBackground" ofType:@"png"];
    mainView.image = [UIImage imageWithContentsOfFile:path];
    mainView.alpha = 1;
    
    mainView.backgroundColor = [UIColor clearColor];
    mainView.layer.cornerRadius = 10;
    mainView.layer.masksToBounds = true;
    [[self view]addSubview:mainView];
    
    int month = [self.currentMonth intValue];
    if(month < 12){
        self.firstRollData = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%i",month],[NSString stringWithFormat:@"%i",month + 1], nil];
    }else{
       self.firstRollData = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%i",12],[NSString stringWithFormat:@"%i",1], nil];
    }
    
    self.secondRollData = [[NSMutableArray alloc]init];
    if(month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12){
        for (int i = 1; i <= 31; i++) {
            [self.secondRollData addObject:[NSString stringWithFormat:@"%i",i]];
        }
    }else if ( month == 2 ){
    
        BOOL isP = [self.currentYear intValue] % 4 == 0;
        if(isP){
            for (int i = 1; i <= 29; i++) {
                [self.secondRollData addObject:[NSString stringWithFormat:@"%i",i]];
            }
        }else{
            for (int i = 1; i <= 28; i++) {
                [self.secondRollData addObject:[NSString stringWithFormat:@"%i",i]];
            }
        }
        
    }else{
        for (int i = 1; i <= 30; i++) {
            [self.secondRollData addObject:[NSString stringWithFormat:@"%i",i]];
        }
    }

    
    leftView = [[UIImageView alloc]initWithFrame:CGRectMake( -230 , (self.view.frame.size.height - 240)/2 + 20, 240, 240)];

    leftView.image = [UIImage imageWithContentsOfFile:path];
    
    leftView.backgroundColor = [UIColor clearColor];
    leftView.layer.cornerRadius = 10;
    leftView.alpha = 0.8;
    leftView.layer.masksToBounds = true;
    leftView.hidden = true;
    [[self view]addSubview:leftView];
    
    
    rightView = [[UIImageView alloc]initWithFrame:CGRectMake( self.view.frame.size.width - 10, (self.view.frame.size.height - 240)/2 + 20, 240, 240)];
    
    rightView.image = [UIImage imageWithContentsOfFile:path];
    rightView.alpha = 0.8;
    
    rightView.backgroundColor = [UIColor clearColor];
    rightView.layer.cornerRadius = 10;
    rightView.layer.masksToBounds = true;
    [[self view]addSubview:rightView];
    
    
    firstPicker = [[UIPickerView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 240) / 2, (self.view.frame.size.height - 240)/2, 120, 240)];
    [[self view]addSubview:firstPicker];
    firstPicker.delegate = self;
    firstPicker.dataSource = self;
    firstPicker.tag = 1;
    
    
    secondPicker = [[UIPickerView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 240) / 2 + 120, (self.view.frame.size.height - 240)/2, 120, 240)];
    [[self view]addSubview:secondPicker];
    secondPicker.delegate = self;
    secondPicker.dataSource = self;
    secondPicker.tag = 2;
}

-(void)ConfirmClick:(UIButton*)sender{
    self.month = [NSString stringWithFormat:@"%li", [firstPicker selectedRowInComponent:0] + 1];
    self.day = self.secondRollData[[secondPicker selectedRowInComponent:0]];
    self.Block();
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)CancelClick:(UIButton*)sender{
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)registerEvent{
    blankTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(blankClick:)];
    blankTap.numberOfTapsRequired = 1;
    [[self view]addGestureRecognizer:blankTap];
    
    leftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [[self view]addGestureRecognizer:leftSwipe];
    
    rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeft:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [[self view]addGestureRecognizer:rightSwipe];
}

-(void)blankClick:(UITapGestureRecognizer *) sender {
    self.Block();
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)swipeRight:(UISwipeGestureRecognizer*)sender{
    if(index > 1){
        
        SystemSoundID soundID = [[sound.sound valueForKey:@"swishin"] intValue];;
        AudioServicesPlaySystemSound(soundID);
        
        CABasicAnimation * animation = [[CABasicAnimation alloc]init];
        animation.keyPath = @"position";
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake((self.view.frame.size.width/2), (self.view.frame.size.height/2))];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake((rightView.center.x), (rightView.center.y))];
        animation.duration = 0.4;
        [mainView.layer addAnimation:animation forKey:@""];
        
        CABasicAnimation * animation1 = [[CABasicAnimation alloc]init];
        animation1.keyPath = @"position";
        animation1.toValue = [NSValue valueWithCGPoint:CGPointMake((self.view.frame.size.width/2), (self.view.frame.size.height/2))];
        animation1.fromValue = [NSValue valueWithCGPoint:CGPointMake((leftView.center.x), (leftView.center.y))];
        animation1.duration = 0.4;
        [rightView.layer addAnimation:animation1 forKey:@""];
        
        CAKeyframeAnimation * keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        keyAnimation.values = @[@1.0, @0.0,@0.0,@1.0];
        keyAnimation.keyTimes = @[@0.0, @0.3,@0.7, @1.0];
        keyAnimation.duration = 0.4;
        [firstPicker.layer addAnimation:keyAnimation forKey:@""];
        [secondPicker.layer addAnimation:keyAnimation forKey:@""];
        
        index -= 1;
        if(index == 1){
            leftView.hidden = true;
        }
        
        if(index < 3){
            rightView.hidden = false;
        }
        
        [firstPicker reloadAllComponents];
        [secondPicker reloadAllComponents];
        
        [self changeTitle];
    }
}

-(void)changeTitle{
    switch (index) {
        case 1:
            titleLabel.text = @"活动日期";
            break;
        case 2:
            titleLabel.text = @"开始时间";
            break;
        case 3:
            titleLabel.text = @"结束时间";
            break;
            
        default:
            break;
    }
}

-(void)swipeLeft:(UISwipeGestureRecognizer*)sender{
    if(index < 3){
        
        SystemSoundID soundID = [[sound.sound valueForKey:@"swishin"] intValue];;
        AudioServicesPlaySystemSound(soundID);
        
        CABasicAnimation * animation = [[CABasicAnimation alloc]init];
        animation.keyPath = @"position";
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake((self.view.frame.size.width/2), (self.view.frame.size.height/2))];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake((leftView.center.x), (leftView.center.y))];
        animation.duration = 0.4;
        animation.delegate = self;
        [mainView.layer addAnimation:animation forKey:@""];
        
        CABasicAnimation * animation1 = [[CABasicAnimation alloc]init];
        animation1.keyPath = @"position";
        animation1.toValue = [NSValue valueWithCGPoint:CGPointMake((self.view.frame.size.width/2), (self.view.frame.size.height/2))];
        animation1.fromValue = [NSValue valueWithCGPoint:CGPointMake((rightView.center.x), (rightView.center.y))];
        animation1.duration = 0.4;
        [rightView.layer addAnimation:animation1 forKey:@""];
        
        
        CAKeyframeAnimation * keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        keyAnimation.values = @[@1.0, @0.0,@0.0,@1.0];
        keyAnimation.keyTimes = @[@0.0, @0.3,@0.7, @1.0];
        keyAnimation.duration = 0.4;
        [firstPicker.layer addAnimation:keyAnimation forKey:@""];
        [secondPicker.layer addAnimation:keyAnimation forKey:@""];
        
        index += 1;
        [firstPicker reloadAllComponents];
        [secondPicker reloadAllComponents];
        
        [self changeTitle];
    }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if(index == 1){
        leftView.hidden = true;
    }else{
        leftView.hidden = false;
    }
    
    if(index == 3){
        rightView.hidden = true;
    }else{
        rightView.hidden = false;
    }
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
    if (index == 1){
        if (pickerView.tag == 1){
            return self.firstRollData.count;
        }
        return self.secondRollData.count;
    }else{
        if (pickerView.tag == 1){
            return hoursDataSource.count;
        }
        return minutesDataSource.count;

    }
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    displaylabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 45)];
    displaylabel.textColor = [UIColor whiteColor];
    displaylabel.textAlignment = NSTextAlignmentCenter;
    displaylabel.font = [UIFont fontWithName:@"Papyrus-Regular" size:45];
    displaylabel.tag = row + 1;
    
    if(index == 1){
        
    displaylabel.text = pickerView.tag == 1? self.firstRollData[row]:self.secondRollData[row];
    }else{
        displaylabel.text = pickerView.tag == 1? hoursDataSource[row]:minutesDataSource[row];
    }
    return displaylabel;
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag == 1){
        return _firstRollData[row];
    }
    return _secondRollData[row];
};

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (index == 1){
    if (pickerView.tag == 1){
        self.month = _firstRollData[row];
        int month = [self.month intValue];
        [self.secondRollData removeAllObjects];
        if(month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12){
            for (int i = 1; i <= 31; i++) {
                [self.secondRollData addObject:[NSString stringWithFormat:@"%i",i]];
            }
        }else if ( month == 2 ){
            
            BOOL isP = [self.currentYear intValue] % 4 == 0;
            if(isP){
                for (int i = 1; i <= 29; i++) {
                    [self.secondRollData addObject:[NSString stringWithFormat:@"%i",i]];
                }
            }else{
                for (int i = 1; i <= 28; i++) {
                    [self.secondRollData addObject:[NSString stringWithFormat:@"%i",i]];
                }
            }
            
        }else{
            for (int i = 1; i <= 30; i++) {
                [self.secondRollData addObject:[NSString stringWithFormat:@"%i",i]];
            }
        }
        [secondPicker reloadAllComponents];
        
    }
    else{
       self.day = _secondRollData[row];
    }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
