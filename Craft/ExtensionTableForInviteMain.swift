//
//  ExtensionTableForInviteMain.swift
//  Craft
//
//  Created by castiel on 16/7/11.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation

extension inviteMain: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("inviteFriendItemCell") as? InviteFriendCell
        
        if cell == nil{
            cell = InviteFriendCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "inviteFriendItemCell",cellWidth: UIAdapter.shared.transferWidth(250),cellHeight:44 )
        }
        
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! InviteFriendCell
        cell.selectedBackgroundImage!.hidden = !cell.selectedBackgroundImage!.hidden
    }

}