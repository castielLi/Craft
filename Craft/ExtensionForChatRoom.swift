//
//  ExtensionForChatRoom.swift
//  Craft
//
//  Created by castiel on 16/5/29.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation

extension ChatRoom : UITableViewDelegate,UITableViewDataSource{

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("chatListCell") as? ChatListCell
        if(cell == nil) {
            
            cell = ChatListCell(style: UITableViewCellStyle.Default, reuseIdentifier: "chatListCell", cellHeight: UIAdapter.shared.transferHeight(50),cellWidth: self.chatListView!.frame.width )
            
            cell!.setTopLineHide()
            cell!.setBottomLineHide()
            
        }
        
        
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UIAdapter.shared.transferHeight(50)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let soundId = soundPlay!.sound.valueForKey(SoundResource.openBookSound) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
        
        if self.chatDetailView!.frame.origin.x < 0{
                UIView.animateWithDuration(0.4, animations: {
                    self.chatDetailView!.frame.origin.x = 0
                    self.enterText!.frame.origin.x = 0
                    
                    self.selectDialog!.frame.origin.x += UIAdapter.shared.transferWidth(220)
                })
        }
        
    }
    
}