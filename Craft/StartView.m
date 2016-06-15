//
//  ViewController.m
//  VideoWelcome
//
//  Created by 王晨晓 on 15/7/15.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "StartView.h"
#import <AVFoundation/AVFoundation.h>
#import "Craft-Swift.h"

typedef NS_ENUM(NSUInteger, buttonDirection) {
    buttonLeft = 0,
    buttonRight,
};

typedef NS_ENUM(NSUInteger, currentStatus) {
    freeStatus = 0,
    loginStatus,
    signupStatus,
};

static const float PLAYER_VOLUME = 0.0;
static const float TITLE_FONT_SIZE = 72.0f;


@interface  StartView(){
    UITapGestureRecognizer * tap;
    AVPlayerItem *playerItem;
    AVPlayerLayer * playerLayer;
}
@property (nonatomic) UILabel *titleLabel;


@property (nonatomic) currentStatus status;

@property (strong, nonatomic) UIView *playerView;

@end

@implementation StartView

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createShowAnim];
    
     [self.navigationController setNavigationBarHidden:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.status = freeStatus;
    
//    _playerView = [[UIView alloc]initWithFrame:CGRectMake(0, -2, self.view.frame.size.width, self.view.frame.size.height + 2)];
//    [[self view]addSubview:_playerView];
    
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    [self createVideoPlayer];
    [self createTitleLabel];
}

-(void)click:(UITapGestureRecognizer*)sender{
    [playerLayer removeFromSuperlayer];
    [playerItem removeObserver:self forKeyPath:@"status"];
//    [self dismissViewControllerAnimated:true completion:^{
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"loginDisappear" object:self];
//    }];
    LoginController * login = [[LoginController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:login animated:true];
}

- (void)createShowAnim {

    CAKeyframeAnimation *keyAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    keyAnim.duration = 5;
    keyAnim.values = @[@0.0, @1.0, @0.0];
    keyAnim.keyTimes = @[@0.0, @0.5, @1.0];
    [self.titleLabel.layer addAnimation:keyAnim forKey:@"opacity"];
}

- (void)createVideoPlayer {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"welcome_video" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    playerItem = [AVPlayerItem playerItemWithURL:url];
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    AVPlayer* player = [AVPlayer playerWithPlayerItem:playerItem];
//    player.volume = PLAYER_VOLUME;

    playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:playerLayer];

    [player play];
    
//    [player.currentItem addObserver:self forKeyPath:AVPlayerItemDidPlayToEndTimeNotification options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
}

- (void)createTitleLabel {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 80, 80)];
    self.titleLabel.alpha = 0.0f;
    self.titleLabel.center = self.view.center;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.text = @"CRAFT";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    self.titleLabel.font = [UIFont systemFontOfSize:TITLE_FONT_SIZE];
    [self.view addSubview:self.titleLabel];
}


#pragma mark - observer of player
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

}

// 视频循环播放
- (void)moviePlayDidEnd:(NSNotification*)notification{
    [playerLayer removeFromSuperlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [playerItem removeObserver:self forKeyPath:@"status"];
//    [self dismissViewControllerAnimated:true completion:^{
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"loginDisappear" object:self];
//    }];
    if(self.navigationController.viewControllers.count == 1){
    LoginController * login = [[LoginController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:login animated:true];
    }
}

#pragma mark - CardView Animation
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
