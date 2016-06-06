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
        }
    }
    
}