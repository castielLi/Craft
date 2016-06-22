//
//  RCIMdelegateForSignUp.swift
//  Craft
//
//  Created by castiel on 16/6/22.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation

extension SignUp{
    
    func onReceived(message: RCMessage!, left nLeft: Int32, object: AnyObject!) {
        if message.content.isMemberOfClass(RCTextMessage.classForCoder()){
            let content =  message.content as! RCTextMessage
            
            var paras : String = (message.content as! RCTextMessage).extra
            
            let data = paras.dataUsingEncoding(NSUTF8StringEncoding)
            do {
                let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject]
                
                print(dictionary)
            } catch let error as NSError {
                print(error)
            }
            
        }
    }
    
    func clearMessage(){
        RCIMClient.sharedRCIMClient().clearMessages(RCConversationType.ConversationType_CHATROOM, targetId: "1")
    }
    
    
    func joinCurrentChatRoom(){
       RCIMClient.sharedRCIMClient().joinChatRoom("1", messageCount: -1, success: {
        
           print("进入聊天室成功")
        
        }) { (error) in
            print(error)
        }
    }
    
}