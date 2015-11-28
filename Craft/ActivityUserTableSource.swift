//
//  ActivityUserTableSource.swift
//  Craft
//
//  Created by castiel on 15/11/28.
//  Copyright © 2015年 castiel. All rights reserved.
//

import Foundation

class ActivityUserTableSource : NSObject , UITableViewDataSource , UITableViewDelegate {
    
    var cellHeight : CGFloat?
    var name : String?
    override init() {
        super.init()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("identify") as? TableViewBaseCell
        if(cell == nil) {
            
            cell = TableViewBaseCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "identify", cellHeight: UIAdapter.shared.transferHeight(60))
            
        }
        
        cell!.imageView!.image = UIImage(named: "userIcon")
        cell!.imageView!.layer.masksToBounds = true
       

        cell!.textLabel!.text = "伊莎贝拉殿下"

        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UIAdapter.shared.transferHeight(60)
    }
}