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

            let id = message.targetId
            
            //需要改bug，当如果 没有带开聊天详情的时候
                if(self.targetId == nil){
                    var inChatList = false
                    var index = 0
                    for item in self.chatListArray!{
                        
                        let userId = item.valueForKey("userId") as? String
                        let groupId = item.valueForKey("groupId") as? String
                        
                        if(userId != nil && userId! == id){
                             inChatList = true
                             break
                        }
                        if(groupId != nil && groupId! == id){
                            inChatList = true
                            break
                        }
                        index += 1
                    }
                    
                    if(inChatList){
                        if(self.selectedIndex == 1){
                            
                            let cell = self.chatListView!.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as! ChatListCell
                            
                            let count = Int(cell.count!.text!)! + 1
                            dispatch_async(dispatch_get_main_queue(), {
                            self.chatListView!.beginUpdates()
                            cell.count!.text = "\(count)"
                            cell.count!.hidden = false
                            self.chatListView!.endUpdates()
                            })
                            
                            self.updateChatCount()
                            
                        }else{
                            self.updateChatCount()
                        }
                    }else{
                        if(self.selectedIndex == 1){
                        
                            self.conversationList = RCIMHelper.RetrunConversationList()
                            self.chatListArray = self.getChatListInfoByRCMArray(self.conversationList!)
                            dispatch_async(dispatch_get_main_queue(), {
                            self.chatListView!.reloadData()
                            })
                            self.updateChatCount()
                            
                        }else{
                            
                            self.updateChatCount()
                            self.conversationList = RCIMHelper.RetrunConversationList()
                            self.chatListArray = self.getChatListInfoByRCMArray(self.conversationList!)
                        }
                    }
                }
                else{
                    let txtMsg = ChatTextMessage(ownerType: .Other, messageType: .Text, portrait: UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("10", ofType: "jpeg")!)!)
                    txtMsg.text = text
                    self.data?.addObject(txtMsg)
                    self.detailTable!.reloadData()
                    self.tableScrollToBottom()
                            
                }
        }
        
        if message.content .isMemberOfClass(RCVoiceMessage.classForCoder()) {
            let content = message.content as! RCVoiceMessage
            let data = content.wavAudioData
            let duration = content.duration
            let extra = content.extra

                let id = message.targetId
                
            if(self.targetId == nil){
                var inChatList = false
                var index = 0
                for item in self.chatListArray!{
                    
                    let userId = item.valueForKey("userId") as? String
                    let groupId = item.valueForKey("groupId") as? String
                    
                    if(userId != nil && userId! == id){
                        inChatList = true
                        break
                    }
                    if(groupId != nil && groupId! == id){
                        inChatList = true
                        break
                    }
                    index += 1
                }
                
                if(inChatList){
                    if(self.selectedIndex == 1){
                        
                        let cell = self.chatListView!.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as! ChatListCell
                        
                        let count = Int(cell.count!.text!)! + 1
                        dispatch_async(dispatch_get_main_queue(), {
                            self.chatListView!.beginUpdates()
                            cell.count!.text = "\(count)"
                            cell.count!.hidden = false
                            self.chatListView!.endUpdates()
                        })
                        
                        self.updateChatCount()
                        
                    }else{
                        self.updateChatCount()
                    }
                }else{
                    if(self.selectedIndex == 1){
                        
                        self.conversationList = RCIMHelper.RetrunConversationList()
                        self.chatListArray = self.getChatListInfoByRCMArray(self.conversationList!)
                        dispatch_async(dispatch_get_main_queue(), {
                            self.chatListView!.reloadData()
                        })
                        self.updateChatCount()
                        
                    }else{
                        
                        self.updateChatCount()
                        self.conversationList = RCIMHelper.RetrunConversationList()
                        self.chatListArray = self.getChatListInfoByRCMArray(self.conversationList!)
                    }
                }
            }else{
            let voiceMsg = ChatVoiceMessage(ownerType: .Other, messageType: .Voice, portrait: UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("10", ofType: "jpeg")!)!, voiceSecs: duration)
                voiceMsg.voiceData = data

                    self.data?.addObject(voiceMsg)
                    self.detailTable!.reloadData()

                self.tableScrollToBottom()
            }

        }
    }
    
    
    func getChatListInfoByRCMArray(RCMarray : NSArray)->NSMutableArray{
        let array = NSMutableArray()
        for item in RCMarray{
            //私聊
            if item.conversationType == RCConversationType.ConversationType_PRIVATE{
            let userId = item.valueForKey("targetId") as! String
            let user = _fmdbHelper!.DatabaseQueryWithParameters(["userId","userName","IconUrl","battleAccount","markName"], query: ChatRoom.searchInfoInFriendList, values: [userId])
            
            if (user != nil && user.count > 0){
                
                let chatContentArray = RCIMClient.sharedRCIMClient().getLatestMessages(RCConversationType.ConversationType_PRIVATE, targetId: userId, count: 1)
                
                if(chatContentArray.count>0){
                    array.addObject(user)
                }
                
               
             }
            }
            if item.conversationType == RCConversationType.ConversationType_GROUP{
               
                let groupId = item.valueForKey("targetId") as! String
                let group = _fmdbHelper!.DatabaseQueryWithParameters(["groupId","groupName","groupIntro","groupCode"], query: ChatRoom.searchInfoInGroupList, values: [groupId])
                
                if(group != nil && group.count > 0){
                    let chatContentArray = RCIMClient.sharedRCIMClient().getLatestMessages(RCConversationType.ConversationType_GROUP, targetId: groupId, count: 1)
                    
                    if(chatContentArray.count>0){
                        
                        array.addObject(group)
                    }
                }
            }
        }
        return array
    }
    
    
    private func updateChatCount(){
        dispatch_async(dispatch_get_main_queue(), {
            let unreadCount = RCIMClient.sharedRCIMClient().getUnreadCount([1])
            let chatButton = ChatNavigationView(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(30) + 5, height: UIAdapter.shared.transferHeight(12) + 20) )
            chatButton.chat!.setBackgroundImage(UIImage(named: "friend"), forState: UIControlState.Normal)
            chatButton.count!.text = "\(unreadCount)"
            
            
            let rightBarButton = UIBarButtonItem(customView: chatButton)
            self.navigationItem.rightBarButtonItem = rightBarButton
        });
    }
    
}