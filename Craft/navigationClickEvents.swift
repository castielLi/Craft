//
//  navigationClickEvents.swift
//  Craft
//
//  Created by castiel on 16/5/29.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation

extension ChatRoom
{

    func calenderClick(sender : UIButton){
        let soundId = soundPlay!.sound.valueForKey(SoundResource.clickEventSound) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
        
        self.disappearChat(self.sign!.showDaily)
    }
    
    func activityClick(sender : UIButton){
        self.disappearChat(self.sign!.showTimer)
    }

}