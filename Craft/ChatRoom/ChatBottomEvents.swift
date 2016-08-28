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
        let friend = AddNewFriend(nibName: nil, bundle: nil)
        let friendNav = UINavigationController(rootViewController: friend)
        friendNav.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        self.presentViewController(friendNav, animated: true, completion: nil)
    }
    
      
    func chatBottomCreateClick(sender : UIButton){
        
    }
    
    func applyAddFriend(sender : UIButton){
        self.showProgress()
        let addModel = ChatMessageModel()
        addModel.type = "agreeToAddFriend"
        addModel.userId = self.currentUserId!
        addModel.content = DBBaseInfoHelper.GetCurrentUserInfo()![1] as! String
        
        let message = RCInformationNotificationMessage()
        message.message = "\(addModel.content!)通过了你的好友请求"
        
        let model = self.inforList![sender.tag] as! InfoMessageModel
        
        self.addTargetId = model.userId!
        
        let currentMessageId = model.messageId!
        
        let json = addModel.currentModelToJsonString()
        message.extra = json
        RCIMClient.sharedRCIMClient().sendMessage(RCConversationType.ConversationType_PRIVATE, targetId: self.addTargetId!, content: message, pushContent: nil, success: { (messageId) in
            print("发送成功")
            
            self.service!.AddFriend(self.addTargetId!)
            self.addTargetId = nil
            
            
            let currentMessage = RCIMClient.sharedRCIMClient().getMessage(currentMessageId) as! RCMessage
            RCIMClient.sharedRCIMClient().deleteMessages([messageId])
            
    
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
