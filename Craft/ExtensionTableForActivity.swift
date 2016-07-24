//
//  ExtensionForActivity.swift
//  Craft
//
//  Created by castiel on 16/5/28.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation

extension SignUp: UITableViewDelegate , UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 2{
        return 10
        }else{
           return chatDetail.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView.tag == 2{
        
        var cell = tableView.dequeueReusableCellWithIdentifier("activityItemCell") as? ActivityItemCell
        
        if cell == nil{
            cell = ActivityItemCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "activityItemCell", cellHeight: UIAdapter.shared.transferHeight(65),cellWidth: self.activityMainView!.activityTabel!.bounds.width )
        }
        
        cell!.backgroundImage!.image = UIImage(named: "activityItem")
        cell!.iconImage!.image = UIImage(named: "challenge")
        cell!.raidName!.text = "纳克萨玛斯"
        cell!.dutyPart!.damageLabel!.text = "13"
        cell!.dutyPart!.tankLabel!.text = "3"
        cell!.dutyPart!.healLabel!.text = "4"
        cell!.contentLabel!.text = "老1-老4,来熟练工，不墨迹 老1-老4,来熟练工，不墨迹 老1-老4,来熟练工，不墨迹"
        cell!.leadName!.text = "伊莎贝拉殿下"
        
        if indexPath.row % 3 == 0 {
            cell!.timePart!.firstPart?.text = "165"
            cell!.timePart!.midPart!.text = ":"
            cell!.timePart!.midPart!.font = UIFont(name: "DB LCD Temp", size: UIAdapter.shared.transferHeight(20))
            cell!.timePart!.secondPart!.text = "43"
        }else{
            cell!.timePart!.firstPart?.text = "07"
            cell!.timePart!.midPart!.text = ":"
            cell!.timePart!.midPart!.font = UIFont(name: "DB LCD Temp", size: UIAdapter.shared.transferHeight(20))
            cell!.timePart!.secondPart!.text = "43"
        }
        
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
        }else{
            var cell = tableView.dequeueReusableCellWithIdentifier("activityItemCell") as? worldChatCell
            
            if cell == nil{
                cell = worldChatCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "activityItemCell", cellWidth: self.view.frame.width - UIAdapter.shared.transferWidth(36) )
            }
            
            cell!.content!.text = chatDetail[indexPath.row] as! String
            
            let size = UILabel.contentSize(self.view.frame.width - UIAdapter.shared.transferWidth(42), font: UIAdapter.shared.transferFont(10), text: chatDetail[indexPath.row] as! String)
            
            cell!.content!.frame.size = size
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
            return cell!
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView.tag == 2{
        return UIAdapter.shared.transferHeight(65)
        }
        else{
            let content = UILabel.contentSize(self.view.frame.width - UIAdapter.shared.transferWidth(42), font: UIAdapter.shared.transferFont(10), text: chatDetail[indexPath.row] as! String)
            
            return UIAdapter.shared.transferHeight(4) + content.height
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView.tag == 2{
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ActivityItemCell
//        cell.backgroundImage!.image = UIImage(named: "activityItem_click")
        
        let soundId = soundPlay!.sound.valueForKey(SoundResource.clickEventSound) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
        
        displayActivityDetail()
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView.tag == 2{
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ActivityItemCell
        cell.backgroundImage!.image = UIImage(named: "activityItem")
        }
    }
}