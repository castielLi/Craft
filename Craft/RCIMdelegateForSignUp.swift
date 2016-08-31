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
            if (message.conversationType == RCConversationType.ConversationType_CHATROOM){
            
                if(nLeft == 0 ){
                
                let content =  message.content as! RCTextMessage
                let text = content.content
                
                let id = message.targetId
                
                let speakContent = "\(content.extra)说:\(text)"
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.chatDetail.addObject(speakContent)
                    let count = self.chatDetail.count
                    self.worldChat!.worldChatDetail!.reloadData()
                    self.worldChat!.worldChatDetail!.scrollToRowAtIndexPath( NSIndexPath(forRow: count - 1  , inSection :0) , atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
                });

                
                }else{
                   return
                }
            }else{
                 self.updateChatCount()
            }
        }
    }
    
    func clearMessage(){
        RCIMClient.sharedRCIMClient().clearMessages(RCConversationType.ConversationType_CHATROOM, targetId: "1")
    }
    
    
    func joinCurrentChatRoom(){
       // 0 是联盟 1是部落
       RCIMClient.sharedRCIMClient().joinChatRoom(self.chatRoomId, messageCount: -1, success: {
        
           print("进入聊天室成功")
        
        }) { (error) in
            print(error)
        }
    }
    
    func quitCurrentChatRoom(){
        // 0 是联盟 1是部落
        RCIMClient.sharedRCIMClient().joinChatRoom(self.chatRoomId, messageCount: -1, success: {
            
            print("退出聊天室成功")
            
        }) { (error) in
            print(error)
        }
    }
    
    
    func updateChatCount(){
        dispatch_async(dispatch_get_main_queue(), {
            let unreadCount = RCIMClient.sharedRCIMClient().getUnreadCount([1,3])
            let chatButton = ChatNavigationView(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(30) + 5, height: UIAdapter.shared.transferHeight(12) + 20) )
            chatButton.chat!.setBackgroundImage(UIImage(named: "friend"), forState: UIControlState.Normal)
            chatButton.count!.text = "\(unreadCount)"
            
            
            let rightBarButton = UIBarButtonItem(customView: chatButton)
            self.navigationItem.rightBarButtonItem = rightBarButton
        });
    }

    
}