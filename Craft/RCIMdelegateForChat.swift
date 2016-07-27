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
            
            let dataExtra = extra.dataUsingEncoding(NSUTF8StringEncoding)
            do {
                let dataDict = try NSJSONSerialization.JSONObjectWithData(dataExtra!, options: []) as? [String: AnyObject]
                let model = ChatMessageModel.getModelFromDictionary(dataDict)
                guard model.type == "chatroom" else { return }
            
                let txtMsg = ChatTextMessage(ownerType: .Other, messageType: .Text, portrait: UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("10", ofType: "jpeg")!)!)
                txtMsg.text = text
                
                
                dispatch_async(dispatch_get_main_queue(), {
                   self.data!.addObject(txtMsg)
                   self.detailTable!.reloadData()
                    });
                
                
                self.tableScrollToBottom()
            
            } catch let error as NSError {
                print(error)
                return
            }
        }
        
        if message.content .isMemberOfClass(RCVoiceMessage.classForCoder()) {
            let content = message.content as! RCVoiceMessage
            let data = content.wavAudioData
            let duration = content.duration
            let extra = content.extra
            let dataExtra = extra.dataUsingEncoding(NSUTF8StringEncoding)
            do {
                let dataDict = try NSJSONSerialization.JSONObjectWithData(dataExtra!, options: []) as? [String: AnyObject]
                let model = ChatMessageModel.getModelFromDictionary(dataDict)
                guard model.type == "chatroom" else { return }
                
                let voiceMsg = ChatVoiceMessage(ownerType: .Other, messageType: .Voice, portrait: UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("10", ofType: "jpeg")!)!, voiceSecs: duration)
                voiceMsg.voiceData = data
                dispatch_async(dispatch_get_main_queue(), {
                    self.data!.addObject(voiceMsg)
                    self.detailTable!.reloadData()
                });
                self.tableScrollToBottom()
            } catch let error as NSError {
                print(error)
                return
            }
        }
    }
    
}