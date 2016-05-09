//
//  PlaySound.m
//  Craft
//
//  Created by castiel on 16/5/9.
//  Copyright © 2016年 castiel. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PlaySound.h"


@implementation PlaySound

+ (PlaySound*)sharedData
{
    static PlaySound *sharedData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData = [[self alloc] init];
    });
    
    [sharedData initSound];
    return sharedData;
}

-(void)initSound{
    
    self.sound = [[NSMutableDictionary alloc]init];

    NSURL *buttonURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"clickevent" ofType:@"mp3"]];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)buttonURL, &soundID );
    
    [self.sound addEntriesFromDictionary:@{@"clickevent":[NSString stringWithFormat:@"%i",soundID]}];
    
    buttonURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"openBook" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)buttonURL, &soundID );
    
    [self.sound addEntriesFromDictionary:@{@"openBook":[NSString stringWithFormat:@"%i",soundID]}];
    
    buttonURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"swishin" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)buttonURL, &soundID );
    
    [self.sound addEntriesFromDictionary:@{@"swishin":[NSString stringWithFormat:@"%i",soundID]}];
    
    buttonURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"swishout" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)buttonURL, &soundID );
    
    [self.sound addEntriesFromDictionary:@{@"swishout":[NSString stringWithFormat:@"%i",soundID]}];
}


@end

