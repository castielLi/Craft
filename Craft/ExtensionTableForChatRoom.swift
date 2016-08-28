//
//  ExtensionForChatRoom.swift
//  Craft
//
//  Created by castiel on 16/5/29.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation

extension ChatRoom : UITableViewDelegate,UITableViewDataSource{

    // table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 11{
            if self.selectedIndex == 1{
               return chatListArray!.count
            }else if selectedIndex == 2{
               return friendListArray!.count
            }else if selectedIndex == 3{
            return self.dataChannels.count
            }else{
              return self.inforList!.count
            }
        }else{
           return self.data!.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView.tag == 11{
            
            if selectedIndex == 1{
            var cell = tableView.dequeueReusableCellWithIdentifier("chatListCell") as? ChatListCell
            if(cell == nil) {
                
                cell = ChatListCell(style: UITableViewCellStyle.Default, reuseIdentifier: "chatListCell", cellHeight: UIAdapter.shared.transferHeight(50),cellWidth: self.chatListView!.frame.width )
                
                
                cell!.setTopLineHide()
                cell!.setBottomLineHide()
                
            }
                
            let userId = self.chatListArray![indexPath.row].valueForKey("userId") as? String
            
            if(userId != nil){
            
            let unreadCount = RCIMClient.sharedRCIMClient().getUnreadCount(RCConversationType.ConversationType_PRIVATE, targetId: userId)
                
            let chatContentArray = RCIMClient.sharedRCIMClient().getLatestMessages(RCConversationType.ConversationType_PRIVATE, targetId: userId!, count: 1)
            
            if(chatContentArray.count>0){
                let objectName = chatContentArray[0].valueForKey("objectName") as! String
                cell!.lastMessageTime = chatContentArray[0].valueForKey("sentTime") as! Int
                let nameComponents = objectName.componentsSeparatedByString(":")
                
                if nameComponents[1] == "VcMsg" {
                    // voice
                    cell!.message!.text = "[语音消息]"
                } else {
                    let content = chatContentArray[0].valueForKey("content")!.valueForKey("content")
                    cell!.message!.text = content as! String
                }
             }
                
                
                let markName = self.chatListArray![indexPath.row].valueForKey("markName") as! String
                
                if(markName == ""){
                    cell!.name!.text = self.chatListArray![indexPath.row].valueForKey("userName") as! String
                }else{
                    cell!.name!.text = markName;
                }
                
                cell!.account!.text = self.chatListArray![indexPath.row].valueForKey("battleAccount") as! String
                
                let iconUrl = self.chatListArray![indexPath.row].valueForKey("IconUrl") as! String
                
                
                if(unreadCount > 0){
                    cell!.count!.text = "\(unreadCount)"
                    cell!.count!.hidden = false
                }else{
                    cell!.count!.text = "0"
                    cell!.count!.hidden = true
                }
                
                
            }else{
                
                let groupId = self.chatListArray![indexPath.row].valueForKey("groupId") as? String
                
                let unreadCount = RCIMClient.sharedRCIMClient().getUnreadCount(RCConversationType.ConversationType_GROUP, targetId: groupId)
                
                
                let chatContentArray = RCIMClient.sharedRCIMClient().getLatestMessages(RCConversationType.ConversationType_GROUP, targetId: groupId, count: 1)
                
                if(chatContentArray.count>0){
                    let objectName = chatContentArray[0].valueForKey("objectName") as! String
                    cell!.lastMessageTime = chatContentArray[0].valueForKey("sentTime") as! Int
                    let nameComponents = objectName.componentsSeparatedByString(":")
                    
                    if nameComponents[1] == "VcMsg" {
                        // voice
                        cell!.message!.text = "[语音消息]"
                    } else {
                        let content = chatContentArray[0].valueForKey("content")!.valueForKey("content")
                        cell!.message!.text = content as! String
                    }
                }
               
                if(unreadCount > 0){
                    cell!.count!.text = "\(unreadCount)"
                    cell!.count!.hidden = false
                }else{
                    cell!.count!.text = "0"
                    cell!.count!.hidden = true
                }
                
                cell!.name!.text = "\(self.chatListArray![indexPath.row].valueForKey("groupName") as! String) (\(self.chatListArray![indexPath.row].valueForKey("groupCode") as! String))"
                
                cell!.account!.text = self.chatListArray![indexPath.row].valueForKey("groupIntro") as! String

            }
                
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
            return cell!
            
            }
            else if selectedIndex == 2{
                
                var cell = tableView.dequeueReusableCellWithIdentifier("chatListCell") as? ChatListCell
                if(cell == nil) {
                    
                    cell = ChatListCell(style: UITableViewCellStyle.Default, reuseIdentifier: "chatListCell", cellHeight: UIAdapter.shared.transferHeight(50),cellWidth: self.chatListView!.frame.width )
                    
                    cell!.setTopLineHide()
                    cell!.setBottomLineHide()
                    
                }
                cell!.count!.hidden = true
                let markName = self.friendListArray![indexPath.row].valueForKey("markName") as! String
                
                if(markName == ""){
                   cell!.name!.text = self.friendListArray![indexPath.row].valueForKey("userName") as! String
                }else{
                    cell!.name!.text = markName;
                }
                
                cell!.account!.text = self.friendListArray![indexPath.row].valueForKey("battleAccount") as! String
                
                let iconUrl = self.friendListArray![indexPath.row].valueForKey("IconUrl") as! String

                
                cell!.selectionStyle = .None
                return cell!
            }else if(selectedIndex == 3)
            {
                var cell = tableView.dequeueReusableCellWithIdentifier("channelCell") as? ChatChannelCell
                if cell == nil {
                    
                    cell = ChatChannelCell(style: .Default, reuseIdentifier: "channelCell", cellHeight: uiah(50), cellWidth: self.chatListView!.frame.width)
                    
                    
                }
                
                let dict: Dictionary<String, AnyObject> = self.dataChannels[indexPath.row]
                cell!.setMessage(dict["title"] as! String, numberInThisChannel: "0", backgroundImage: dict["backgroundImage"] as! UIImage)
                
                cell!.selectionStyle = .None
                cell!.setTopLineHide()
                cell!.setBottomLineHide()
                return cell!
            }else{
                
                var cell = tableView.dequeueReusableCellWithIdentifier("FriendAndGroupApply") as? FriendAndGroupApply
                if cell == nil {
                    
                    cell = FriendAndGroupApply(style: .Default, reuseIdentifier: "FriendAndGroupApply", height: uiah(40), width: self.chatListView!.frame.width)
                    
                    
                }
                
                let model = self.inforList![indexPath.row] as! InfoMessageModel

                cell!.icon!.image = UIImage(named: "playericon")
                cell!.name!.text = model.content!
               
                
                if(model.type! == "friend"){
                    cell!.applyButton!.hidden = false
                     cell!.content!.text = model.message!
                    cell!.applyButton!.tag = indexPath.row
                    cell!.applyButton!.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
                    cell!.applyButton!.setTitle("接受", forState: UIControlState.Normal)
                    cell!.applyButton!.backgroundColor = UIColor.clearColor()
                    cell!.applyButton!.addTarget(self, action: "applyAddFriend:", forControlEvents: UIControlEvents.TouchUpInside)
                }else if (model.type! == "agreeToAddFriend"){
                    cell!.applyButton!.hidden = false
                     cell!.content!.text = "请求添加你为好友"
                    cell!.applyButton!.tag = indexPath.row
                    cell!.applyButton!.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
                    cell!.applyButton!.setTitle("已添加", forState: UIControlState.Normal)
                    cell!.applyButton!.backgroundColor = UIColor.clearColor()
                }
                
                
                cell!.selectionStyle = .None
                cell!.setTopLineHide()
                cell!.setBottomLineHide()
                return cell!

            }
            
        }else {
        
            let message = self.data![indexPath.row] as! ChatMessage
            
            let cell = tableView.dequeueReusableCellWithIdentifier(message.cellIdentity) as! ChatCell
            if message.messageType == .Text {
                (cell as! ChatTextCell).setMessage(message)
                return cell as! ChatTextCell
            } else {
                // voice
                (cell as! ChatVoiceCell).setMessage(message)
                (cell as! ChatVoiceCell).closureVoice = {
                    print("play")
                    if (message as! ChatVoiceMessage).voiceData != nil {
                        // Launch image animation.
                        // animationImages of a UIImageView do not conflict with its image property.
                        var imageArray: [UIImage]? = [UIImage(named: "message_voice_sender_playing_1")!, UIImage(named: "message_voice_sender_playing_2")!, UIImage(named: "message_voice_sender_playing_3")!]
                        if (cell as! ChatVoiceCell).message?.ownerType == .Other {
                            imageArray = [UIImage(named: "message_voice_receiver_playing_1")!, UIImage(named: "message_voice_receiver_playing_2")!, UIImage(named: "message_voice_receiver_playing_3")!]
                        }
                        (cell as! ChatVoiceCell).imageViewWave?.animationImages = imageArray
                        (cell as! ChatVoiceCell).imageViewWave?.animationDuration = 3 * 0.5
                        (cell as! ChatVoiceCell).imageViewWave?.animationRepeatCount = 0
                        (cell as! ChatVoiceCell).imageViewWave?.startAnimating()
                        (cell as! ChatVoiceCell).imageViewMessageBackground?.userInteractionEnabled = false
                        
                        self.rtAudio.completionHandler = {
                            (cell as! ChatVoiceCell).imageViewMessageBackground?.userInteractionEnabled = true
                            (cell as! ChatVoiceCell).imageViewWave?.stopAnimating()
                        }
                        
                        self.rtAudio.playExisted((message as! ChatVoiceMessage).voiceData!)
                    }
                }
                return cell as! ChatVoiceCell
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView.tag == 11{
            if self.selectedIndex == 4{
               return UIAdapter.shared.transferHeight(40)
            }else{
               return UIAdapter.shared.transferHeight(50)
            }
        }else {
            var height: CGFloat = 60
            let message = self.data![indexPath.row] as! ChatMessage
            if message.messageType == .Text {

                let cell = ChatTextCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
                
                height = (message as! ChatTextMessage).messageSize!.height + 2 * cell.gapLabelMessage + 2 * cell.gapPortrait
            }
            return height

        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView.tag == 11{
            
            if(selectedIndex == 4){
               return
            }
            
            var userId : String? = ""
            var groupId : String? = ""
            
            let soundId = soundPlay!.sound.valueForKey(SoundResource.openBookSound) as! String
            let id = UInt32(soundId)
            AudioServicesPlaySystemSound(id!);
            
           
                
            if self.chatDetailView!.frame.origin.x < 0{
                    UIView.animateWithDuration(0.4, animations: {
                        self.chatDetailView!.frame.origin.x = 0
                        self.enterForm!.frame.origin.x = UIAdapter.shared.transferWidth(10)
                        self.selectDialog!.frame.origin.x += UIAdapter.shared.transferWidth(220)
                        }, completion: { (success) in
                             self.setDetailTable()
                    })
            }
            
            self.enterForm?.enterTextView?.text = ""
            self.data?.removeAllObjects()
            
            // RT Start
            var data: NSMutableArray?
            
            if self.selectedIndex == 1 {
                userId = self.chatListArray![indexPath.row].valueForKey("userId") as? String
                groupId = self.chatListArray![indexPath.row].valueForKey("groupId") as? String
                data = self.chatListArray
                
                let cell = tableView.cellForRowAtIndexPath(indexPath) as! ChatListCell
                
                if(userId != nil){
                RCIMClient.sharedRCIMClient().sendReadReceiptMessage(RCConversationType.ConversationType_PRIVATE, targetId: userId!, time: Int64(cell.lastMessageTime!))
                }
                //融云现在不支持控制群组消息状态
                else{
                    
                    let unreadCount = RCIMClient.sharedRCIMClient().getUnreadCount(RCConversationType.ConversationType_GROUP, targetId: groupId)
                    
                    let array = RCIMClient.sharedRCIMClient().getLatestMessages(RCConversationType.ConversationType_GROUP, targetId: groupId, count: unreadCount)
                    
                    if array != nil && array.count > 0 {
                    
                        for item in array{
                            let currentItem = item as! RCMessage
                            RCIMClient.sharedRCIMClient().setMessageReceivedStatus(currentItem.messageId, receivedStatus: RCReceivedStatus.ReceivedStatus_READ)
                        }
                        
                    }
  
                }
                
                tableView.beginUpdates()
                
                cell.count!.text = "0"
                cell.count!.hidden = true
                
                tableView.endUpdates()
                
                let unreadCount = RCIMClient.sharedRCIMClient().getTotalUnreadCount()
                let chatButton = ChatNavigationView(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(30) + 5, height: UIAdapter.shared.transferHeight(12) + 20) )
                chatButton.chat!.setBackgroundImage(UIImage(named: "friend"), forState: UIControlState.Normal)
                chatButton.count!.text = "\(unreadCount)"
                
                
                let rightBarButton = UIBarButtonItem(customView: chatButton)
                self.navigationItem.rightBarButtonItem = rightBarButton
                
                
                
            }
            else if self.selectedIndex == 2 {
                
                let targetId = self.friendListArray![indexPath.row].valueForKey("userId") as! String
                var hasTarget :Bool = false
                for item in self.chatListArray!{
                    if((item.valueForKey("userId") as? String) != nil && (item.valueForKey("userId") as? String)! == targetId ){
                        hasTarget = true
                        break
                    }
                }
                
                if(!hasTarget){
                   self.chatListArray!.insertObject(self.friendListArray![indexPath.row], atIndex: 0)
                }
                
                userId = targetId
                data = self.chatListArray!
                
                self.selectedIndex = 1
                chatListView!.reloadData()
                self.changeBottomOpreatorView()
                
            }
            else if selectedIndex == 3{
                let targetId = (self.dataChannels[indexPath.row] as NSDictionary).valueForKey("targetId") as! String
                if Int(targetId) > 100{
                var hasTarget :Bool = false
                    for item in self.chatListArray!{
                        if((item.valueForKey("groupId") as? String) != nil && (item.valueForKey("groupId") as? String)! == targetId ){
                            hasTarget = true
                            break
                        }
                    }
                    
                    if(!hasTarget){
//                        self.chatListArray!.insertObject(self.dataChannels[indexPath.row], atIndex: 0)
                        
                    }
                    data = self.chatListArray!
                    groupId = targetId
                    self.selectedIndex = 1
                    chatListView!.reloadData()
                    self.changeBottomOpreatorView()
                }else{
                   data = NSMutableArray()
                    
                   let chatRoomNumber = (self.dataChannels[indexPath.row] as NSDictionary).valueForKey("targetId") as! String
                   joinCurrentChatRoom( chatRoomNumber )
                   self.chatRoomNumber = chatRoomNumber
                }
            }
            
            guard data!.count > 0 else { return }
            
            
            
            print("userId: \(userId), groupId: \(groupId)")
            if (userId != nil && userId != "") {
                self.targetId = userId
                self.chatType = RCConversationType.ConversationType_PRIVATE
                
                let chatContentArray = RCIMClient.sharedRCIMClient().getLatestMessages(RCConversationType.ConversationType_PRIVATE, targetId: userId!, count: 5)
                
                
                if(chatContentArray.count>0){
                    for item in chatContentArray{
                    let objectName = item.valueForKey("objectName") as! String
                    let nameComponents = objectName.componentsSeparatedByString(":")
                    
                    var ownerType = MessageOwnerType.Mine
                    if( (item.valueForKey("senderUserId") as! String) != self.currentUserId!){
                        
                        ownerType = MessageOwnerType.Other
                    }
                    
                    
                    if nameComponents[1] == "VcMsg" {
                        // voice
                        let durant = item.valueForKey("content")!.valueForKey("duration") as! Int
                        let voiceData = item.valueForKey("content")!.valueForKey("wavAudioData") as! NSData
                        let voiceMsg = ChatVoiceMessage(ownerType: ownerType, messageType: .Voice, portrait: UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("10", ofType: "jpeg")!)!, voiceSecs: durant)
                        voiceMsg.voiceData = voiceData
                        self.data!.insertObject(voiceMsg, atIndex: 0)
                        
                    } else {
                        let content = item.valueForKey("content")!.valueForKey("content")
                        
                        let txtMsg = ChatTextMessage(ownerType: ownerType, messageType: .Text, portrait: UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("10", ofType: "jpeg")!)!)
                        txtMsg.text = content as! String
                        self.data!.insertObject(txtMsg, atIndex: 0)
                        
                        }
                    }
                }
                self.detailTable?.reloadData()
                return
            }
            if (groupId != nil  && groupId != ""){
                self.targetId = groupId
                self.chatType = RCConversationType.ConversationType_GROUP
                
                
                let chatContentArray = RCIMClient.sharedRCIMClient().getLatestMessages(RCConversationType.ConversationType_GROUP, targetId: groupId!, count: 5)
                
                if(chatContentArray.count>0){
                    for item in chatContentArray{
                        
                    var ownerType = MessageOwnerType.Mine
                    if( (item.valueForKey("senderUserId") as! String) != self.currentUserId!){
                      
                        ownerType = MessageOwnerType.Other
                    }
                        
                    let objectName = item.valueForKey("objectName") as! String
                    let nameComponents = objectName.componentsSeparatedByString(":")
                    
                    if nameComponents[1] == "VcMsg" {
                        // voice
                        let durant = item.valueForKey("content")!.valueForKey("duration") as! Int
                        let voiceData = item.valueForKey("content")!.valueForKey("wavAudioData") as! NSData
                        let voiceMsg = ChatVoiceMessage(ownerType: ownerType, messageType: .Voice, portrait: UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("10", ofType: "jpeg")!)!, voiceSecs: durant)
                        voiceMsg.voiceData = voiceData
                        self.data!.insertObject(voiceMsg, atIndex: 0)
                        
                    } else {
                        let content = item.valueForKey("content")!.valueForKey("content")
                        
                        let txtMsg = ChatTextMessage(ownerType: ownerType, messageType: .Text, portrait: UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("10", ofType: "jpeg")!)!)
                        txtMsg.text = content as! String
                        self.data!.insertObject(txtMsg, atIndex: 0)
                        }
                    }

                }
            }
            

            self.detailTable?.reloadData()
            self.tableScrollToBottom()
            return
        }
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        if(tableView.tag == 11){
            if(selectedIndex == 1){
        let delete = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "删除") { (UITableViewRowAction, NSIndexPath) in
            
            let userId = self.chatListArray![indexPath.row].valueForKey("userId") as? String
            
            let type = userId != nil ? RCConversationType.ConversationType_PRIVATE : RCConversationType.ConversationType_GROUP
                if(type == RCConversationType.ConversationType_PRIVATE){
                    
                   RCIMClient.sharedRCIMClient().clearMessages(type, targetId: userId!)
                    
                   self.updateChatCount()
 
                }else{
                   let groupId = self.chatListArray![indexPath.row].valueForKey("groupId") as? String
                   RCIMClient.sharedRCIMClient().clearMessages(type, targetId: groupId!)
                }
            
            self.chatListArray!.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([ indexPath ], withRowAnimation: UITableViewRowAnimation.Left)
            self.targetId = nil
            }
            
            delete.backgroundColor = UIColor.blackColor()
            
            return [delete]
            }else if (selectedIndex == 2){
                let delete = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "删除") { (UITableViewRowAction, NSIndexPath) in
                    
                    let userId = self.chatListArray![indexPath.row].valueForKey("userId") as? String
                    
                    RCIMClient.sharedRCIMClient().clearMessages(RCConversationType.ConversationType_PRIVATE, targetId: userId!)
                        
                    self.friendListArray!.removeObjectAtIndex(indexPath.row)
                    
                    //删除chatlist的纪录
                    for item in self.chatListArray!{
                        if( item.valueForKey("userId") != nil && (item.valueForKey("userId") as! String) == userId!){
                            self.chatListArray!.removeObject(item)
                        }
                    }
                    
                    tableView.deleteRowsAtIndexPaths([ indexPath ], withRowAnimation: UITableViewRowAnimation.Left)
                    self.targetId = nil
                    
                }
                
                delete.backgroundColor = UIColor.blackColor()
                
                return [delete]
            }else if(selectedIndex == 3){
                let delete = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "删除") { (UITableViewRowAction, NSIndexPath) in
                    
                    let targetId = (self.dataChannels[indexPath.row] as NSDictionary).valueForKey("targetId") as? String
                
                    RCIMClient.sharedRCIMClient().clearMessages(RCConversationType.ConversationType_GROUP, targetId: targetId!)
                    
                    self.dataChannels.removeAtIndex(indexPath.row)
                    
                    //删除chatlist的纪录
                    for item in self.chatListArray!{
                        if( item.valueForKey("groupId") != nil && (item.valueForKey("groupId") as! String) == targetId!){
                          self.chatListArray!.removeObject(item)
                        }
                    }
                    
                    tableView.deleteRowsAtIndexPaths([ indexPath ], withRowAnimation: UITableViewRowAnimation.Left)
                    self.targetId = nil
                    
                }
                
                delete.backgroundColor = UIColor.blackColor()
                
                return [delete]
            }else{
                let delete = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "删除") { (UITableViewRowAction, NSIndexPath) in
                    
                    RCIMClient.sharedRCIMClient().deleteMessages([(self.inforList![indexPath.row] as! InfoMessageModel).messageId!])
                    
                    self.inforList!.removeObjectAtIndex(indexPath.row)
                    
            
                    tableView.deleteRowsAtIndexPaths([ indexPath ], withRowAnimation: UITableViewRowAnimation.Left)
                    self.targetId = nil
                    
                }
                
                delete.backgroundColor = UIColor.blackColor()
                
                return [delete]

            }
        }else{
           return nil
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if(tableView.tag == 11){
            if(self.selectedIndex == 1){
              return true
            }else if (self.selectedIndex == 3){
                if(indexPath.row < 9){
                    return false
                }
                return true
            }else{
                return true
            }
        }else{
          return false
        }
    }
    
    func joinCurrentChatRoom(chatRoomNumber : String){
        RCIMClient.sharedRCIMClient().joinChatRoom(chatRoomNumber, messageCount: -1, success: {
            
            print("进入聊天室成功")
            
        }) { (error) in
            print(error)
        }
    }
    
    func quitCurrentChatRoom(chatRoomNumber : String){
        RCIMClient.sharedRCIMClient().quitChatRoom(chatRoomNumber, success: {
            print("退出聊天室成功")
            self.chatRoomNumber = nil
            }) { (error) in
                print(error)
        }
    }

    
}