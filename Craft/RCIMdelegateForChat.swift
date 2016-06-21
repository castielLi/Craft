//
//  RCIMdelegateForChat.swift
//  Craft
//
//  Created by castiel on 16/6/4.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation

extension ChatRoom{
  
    func onReceived(message: RCMessage!, left nLeft: Int32, object: AnyObject!) {
        if message.content.isMemberOfClass(RCTextMessage.classForCoder()){
            let content =  message.content as! RCTextMessage
            let text = content.content
            let extra = content.extra
            
            let txtMsg = ChatTextMessage(ownerType: .Other, messageType: .Text, portrait: UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("10", ofType: "jpeg")!)!)
            txtMsg.text = text
            self.data.append(txtMsg)
            self.detailTable?.reloadData()
            self.tableScrollToBottom()
        }
        
        if message.content .isMemberOfClass(RCVoiceMessage.classForCoder()) {
            let content = message.content as! RCVoiceMessage
            let data = content.wavAudioData
            let duration = content.duration
            
            let voiceMsg = ChatVoiceMessage(ownerType: .Other, messageType: .Voice, portrait: UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("10", ofType: "jpeg")!)!, voiceSecs: duration)
            voiceMsg.voiceData = data
            self.data.append(voiceMsg)
            self.detailTable?.reloadData()
            self.tableScrollToBottom()
        }
    }
    
}