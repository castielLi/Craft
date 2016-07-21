//
//  TwoRollSelection.m
//  NovaiOS
//
//  Created by castiel on 16/4/14.
//  Copyright © 2016年 hecq. All rights reserved.
//

#import "TwoRollSelection.h"
#import "UIColorHelper.h"

@interface TwoRollSelection (){
    UIView * mainView;
    UIPickerView * firstPicker;
    UIPickerView * secondPicker;
    UIButton * confirm;
    UIButton * cancel;
    UITapGestureRecognizer * blankTap;
    UILabel * splitLabel;
    UILabel * buttonsplitLabel;
}

@end

@implementation TwoRollSelection

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initView{
    
    UIBlurEffect * beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    mainView = [[UIView alloc]init];
    mainView.alpha = 1;
    mainView = [[UIVisualEffectView alloc]initWithEffect:beffect];
    mainView.layer.borderWidth = 1;
    mainView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    mainView.layer.cornerRadius = 10;
    mainView.layer.masksToBounds = true;
    [[self view]addSubview:mainView];
    
    
//    [mainView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:(self.view.frame.size.height - 330) / 2];
//    [mainView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:(self.view.frame.size.width - 300) / 2];
//    [mainView autoSetDimension:ALDimensionWidth toSize:300];
//    [mainView autoSetDimension:ALDimensionHeight toSize:330];
    
    
    firstPicker = [[UIPickerView alloc]init];
    [[self view]addSubview:firstPicker];
    firstPicker.delegate = self;
    firstPicker.dataSource = self;
    firstPicker.tag = 1;
    
//    [firstPicker autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:(self.view.frame.size.height - 330) / 2];
//    [firstPicker autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:(self.view.frame.size.width - 300) / 2];
//    [firstPicker autoSetDimension:ALDimensionWidth toSize:150];
//    [firstPicker autoSetDimension:ALDimensionHeight toSize:280];
    
    
    secondPicker = [[UIPickerView alloc]init];
    [[self view]addSubview:secondPicker];
    secondPicker.delegate = self;
    secondPicker.dataSource = self;
    secondPicker.tag = 2;
    
//    [secondPicker autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:(self.view.frame.size.height - 330) / 2];
//    [secondPicker autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:(self.view.frame.size.width - 300) / 2 + 150];
//    [secondPicker autoSetDimension:ALDimensionWidth toSize:150];
//    [secondPicker autoSetDimension:ALDimensionHeight toSize:280];
    
    
    splitLabel = [[UILabel alloc]init];
    splitLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    splitLabel.layer.borderWidth =1;
    [mainView addSubview:splitLabel];
    
//    [splitLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:firstPicker];
//    [splitLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
//    [splitLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
//    [splitLabel autoSetDimension:ALDimensionHeight toSize:1];
    
    confirm = [[UIButton alloc]init];
    
    [confirm setTitle:@"Confirm" forState:UIControlStateNormal];
    [confirm addTarget:self action:@selector(ConfirmClick:) forControlEvents:UIControlEventTouchUpInside];
    [confirm setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [mainView addSubview:confirm];
    confirm.titleLabel.font = [UIFont systemFontOfSize:20.0];
//    [UIFont fontWithName:@"AlNile-Bold" size:20];
    
//    [confirm autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:firstPicker withOffset:1];
//    [confirm autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
//    [confirm autoSetDimension:ALDimensionWidth toSize:149];
//    [confirm autoSetDimension:ALDimensionHeight toSize:50];
    
    
    buttonsplitLabel = [[UILabel alloc]init];
    buttonsplitLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    buttonsplitLabel.layer.borderWidth =1;
    [mainView addSubview:buttonsplitLabel];
    
//    [buttonsplitLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:firstPicker];
//    [buttonsplitLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView: confirm];
//    [buttonsplitLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView: confirm withOffset:1];
//    [buttonsplitLabel autoSetDimension:ALDimensionHeight toSize:50];
    
    
    cancel = [[UIButton alloc]init];
    [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(CancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [mainView addSubview:cancel];
    cancel.titleLabel.font = [UIFont systemFontOfSize:20.0];
//    [UIFont fontWithName:@"AlNile-Bold" size:20];

//    [cancel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:firstPicker withOffset:1];
//    [cancel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
//    [cancel autoSetDimension:ALDimensionWidth toSize:150];
//    [cancel autoSetDimension:ALDimensionHeight toSize:50];

}

-(void)ConfirmClick:(UIButton*)sender{
    self.month = [NSString stringWithFormat:@"%li", [firstPicker selectedRowInComponent:0] + 1];
    self.year = self.secondRollData[[secondPicker selectedRowInComponent:0]];
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
    if (pickerView.tag == 1){
        return _firstRollData.count;
    }
    return _secondRollData.count;
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag == 1){
        return _firstRollData[row];
    }
    return _secondRollData[row];
};

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView.tag == 1){
        self.month = [NSString stringWithFormat:@"%li",row+1];
    }
    else{
       self.year = _secondRollData[row];
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
