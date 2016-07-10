//
//  ExtensionTableForCreateActivitiy.swift
//  Craft
//
//  Created by castiel on 16/7/10.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

extension AddNewActivityController : UITableViewDelegate,UITableViewDataSource{

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("createActivityItemCell") as? InviteTableCell
        
        if cell == nil{
            cell = InviteTableCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "createActivityItemCell",cellWidth: UIAdapter.shared.transferWidth(248),cellHeight:44 )
        }

        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    }
    
}
