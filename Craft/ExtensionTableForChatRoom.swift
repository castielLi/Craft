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
        if tableView.tag == 1{
        if self.selectedIndex == 1{
           return conversationList!.count
        }
            return 10
        }else{
           return self.data.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView.tag == 1{
        var cell = tableView.dequeueReusableCellWithIdentifier("chatListCell") as? ChatListCell
        if(cell == nil) {
            
            cell = ChatListCell(style: UITableViewCellStyle.Default, reuseIdentifier: "chatListCell", cellHeight: UIAdapter.shared.transferHeight(50),cellWidth: self.chatListView!.frame.width )
            
            cell!.setTopLineHide()
            cell!.setBottomLineHide()
            
        }
        
        
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
        }else{
        
            let message = self.data[indexPath.row]
            
            let cell = tableView.dequeueReusableCellWithIdentifier(message.cellIdentity) as! ChatCell
            if message.messageType == .Text {
                (cell as! ChatTextCell).setMessage(message)
                return cell as! ChatTextCell
            } else {
                // voice
                (cell as! ChatVoiceCell).setMessage(message)
                return cell as! ChatVoiceCell
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView.tag == 1{
        return UIAdapter.shared.transferHeight(50)
        }else{
            var height: CGFloat = 60
            let message = self.data[indexPath.row]
            if message.messageType == .Text {

                let cell = ChatTextCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
                
                height = (message as! ChatTextMessage).messageSize!.height + 2 * cell.gapLabelMessage + 2 * cell.gapPortrait
            }
            return height

        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView.tag == 1{
        let soundId = soundPlay!.sound.valueForKey(SoundResource.openBookSound) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
        
        if self.chatDetailView!.frame.origin.x < 0{
                UIView.animateWithDuration(0.4, animations: {
                    self.chatDetailView!.frame.origin.x = 0
                    self.enterText!.frame.origin.x = 0
                    self.detailTable!.frame.origin.x = UIAdapter.shared.transferWidth(10)
                    self.selectDialog!.frame.origin.x += UIAdapter.shared.transferWidth(220)
                })
           }
        }
        
    }
    
}