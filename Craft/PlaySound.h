//
//  PlaySound.h
//  Craft
//
//  Created by castiel on 16/5/9.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface PlaySound : NSObject

+ (PlaySound*)sharedData;

@property (nonatomic,strong)NSMutableDictionary* sound;

-(instancetype)init;

-(void)initSound;


@end