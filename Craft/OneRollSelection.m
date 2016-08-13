//
//  OneRollSelection.m
//  NovaiOS
//
//  Created by castiel on 16/4/8.
//  Copyright © 2016年 hecq. All rights reserved.
//

#import "OneRollSelection.h"

@interface OneRollSelection (){
    UIImageView * mainView;
    UIPickerView * picker;
    UIButton * confirm;
    UIButton * cancel;
    UITapGestureRecognizer * blankTap;
    UILabel * splitLabel;
    UILabel * buttonsplitLabel;
    UITapGestureRecognizer * tap;
    UILabel * displaylabel;
    
}
@end

@implementation OneRollSelection

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isNotify = false;
    self.view.backgroundColor = [UIColor clearColor];
    [self initView];
    [self registerEvent];
    // Do any additional setup after loading the view.
}

-(void)initView{

    
   
    
    mainView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 240) / 2, (self.view.frame.size.height - 240)/2, 240, 240)];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"selectedBackground" ofType:@"png"];
    mainView.image = [UIImage imageWithContentsOfFile:path];
    mainView.alpha = 1;

    mainView.backgroundColor = [UIColor clearColor];
    mainView.layer.cornerRadius = 10;
    mainView.layer.masksToBounds = true;
    [[self view]addSubview:mainView];
    
   
    
    
    picker = [[UIPickerView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 240) / 2, (self.view.frame.size.height - 240)/2, 240, 240)];
    [[self view]addSubview:picker];
    picker.delegate = self;
    picker.dataSource = self;
    picker.showsSelectionIndicator = NO;
    
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selected:)];
    tap.numberOfTapsRequired = 1;
    [mainView addGestureRecognizer:tap];
    
    
//    splitLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 280, 300, 1)];
//    splitLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    splitLabel.layer.borderWidth =1;
//    [mainView addSubview:splitLabel];
//
//    
//    confirm = [[UIButton alloc]initWithFrame:CGRectMake(0, 281, 150, 50)];
//    [confirm setTitle:@"Confirm" forState:UIControlStateNormal];
//    [confirm addTarget:self action:@selector(ConfirmClick:) forControlEvents:UIControlEventTouchUpInside];
//    [confirm setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [mainView addSubview:confirm];
//    
//    confirm.titleLabel.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:20];
//    
//    
//    
//    buttonsplitLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 280, 1, 50)];
//    buttonsplitLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    buttonsplitLabel.layer.borderWidth =1;
//    [mainView addSubview:buttonsplitLabel];
//
//    
//    
//    cancel = [[UIButton alloc]initWithFrame:CGRectMake(151, 281, 149, 50)];
//    [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
//    [cancel addTarget:self action:@selector(CancelClick:) forControlEvents:UIControlEventTouchUpInside];
//    [cancel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [mainView addSubview:cancel];
//    
//    cancel.titleLabel.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:20];




}

-(void)ConfirmClick:(UIButton*)sender{
    if (![self.displayKey  isEqual: @""] && ![self.valueKey  isEqual: @""]){
    self.key = [self.dataArray[[picker selectedRowInComponent:0]] valueForKey:self.displayKey];
    self.value = [self.dataArray[[picker selectedRowInComponent:0]] valueForKey:self.valueKey];
    }else{
        self.key = self.dataArray[[picker selectedRowInComponent:0]];
        self.value = [NSString stringWithFormat:@"%li" ,[picker selectedRowInComponent:0]];
    }
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
}

-(void)blankClick:(UITapGestureRecognizer *) sender {
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
    return _dataArray.count;
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    displaylabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 240, 30)];
    displaylabel.textColor = [UIColor whiteColor];
    displaylabel.text = [_dataArray[row] valueForKey:self.displayKey];
    displaylabel.textAlignment = NSTextAlignmentCenter;
    displaylabel.tag = row + 1;
    displaylabel.font = [UIFont fontWithName:@"KaiTi" size:25.0];
    return displaylabel;
    
}

-(void)selected:(UITapGestureRecognizer *)sender{
    NSLog(@"click me");
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.value = [_dataArray[row] valueForKey:self.valueKey];
    self.key = [_dataArray[row] valueForKey:self.displayKey];
    self.Block();
}


-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
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
