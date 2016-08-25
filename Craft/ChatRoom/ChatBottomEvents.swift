//
//  ChatBottomEvents.swift
//  Craft
//
//  Created by castiel on 16/8/21.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

extension ChatRoom:ChatServiceDelegate{
    
    func chatBottomSearchClick(sender : UIButton){
      
    }
    
    func chatBottomAddClick(sender : UIButton){
    
        if(self.selectedIndex == 2){
            self.addTargetId = "2"
            let addModel = ChatMessageModel()
            addModel.type = "friend"
            addModel.userId = self.currentUserId!
            addModel.content = DBBaseInfoHelper.GetCurrentUserInfo()![1] as! String
            
            let message = RCInformationNotificationMessage()
            message.message = "申请加你为好友"
            
            let json = addModel.currentModelToJsonString()
            message.extra = json
            RCIMClient.sharedRCIMClient().sendMessage(RCConversationType.ConversationType_PRIVATE, targetId: self.addTargetId!, content: message, pushContent: nil, success: { (messageId) in
                print("发送成功")
                self.addTargetId = nil
                
                
                }, error: { (error, messageId) in
                    print("发送失败")
                   
            })

            
        }else{
        
        }
    }
    
    func chatBottomCreateClick(sender : UIButton){
        
    }
    
    func applyAddFriend(sender : UIButton){
        self.showProgress()
        let addModel = ChatMessageModel()
        addModel.type = "acceptFriend"
        addModel.userId = self.currentUserId!
        addModel.content = DBBaseInfoHelper.GetCurrentUserInfo()![1] as! String
        
        let message = RCInformationNotificationMessage()
        message.message = "\(addModel.content!)通过了你的好友请求"
        
        self.addTargetId = (self.inforList![sender.tag] as! InfoMessageModel).userId!
        
        let json = addModel.currentModelToJsonString()
        message.extra = json
        RCIMClient.sharedRCIMClient().sendMessage(RCConversationType.ConversationType_PRIVATE, targetId: self.addTargetId!, content: message, pushContent: nil, success: { (messageId) in
            print("发送成功")
            
            
            self.service!.AddFriend(self.addTargetId!)
            self.addTargetId = nil
            
            }, error: { (error, messageId) in
                print("发送失败")
                
                self.closeProgress()
                
        })
    }
    
    func DidAddFriendFinish(result: ApiResult!, response: AnyObject!) {
        self.closeProgress()
        if(result.state){
            loginService!.GetMyFriends()
        }else{
            MsgBoxHelper.show("错误", message: result.message)
        }
    }

}
