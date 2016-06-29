//
//  SliderNavEvents.swift
//  Craft
//
//  Created by castiel on 16/5/29.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation

extension SliderMain{

    func ChatClick(sender : UIButton){
        let soundId = soundPlay!.sound.valueForKey(SoundResource.clickEventSound) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
        self.disappearDaily(self.sign!.showChat)
    }
    
    func activityClick(sender : UIButton){
        self.disappearDaily(self.sign!.showTimer)
    }
}