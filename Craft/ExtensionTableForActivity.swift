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
        return myActivitiesDatasource!.count
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
          
        let level = myActivitiesDatasource![indexPath.row].valueForKey("aplName") as! String
        if level == "普通"{
        cell!.iconImage!.image = UIImage(named: "challenge")
        }
            
        cell!.raidName!.text = myActivitiesDatasource![indexPath.row].valueForKey("title") as! String
        cell!.dutyPart!.damageLabel!.text = "\(myActivitiesDatasource![indexPath.row].valueForKey("haveDPSCount") as! Int)"
        cell!.dutyPart!.tankLabel!.text = "\(myActivitiesDatasource![indexPath.row].valueForKey("haveTankCount") as! Int)"
        cell!.dutyPart!.healLabel!.text = "\(myActivitiesDatasource![indexPath.row].valueForKey("haveHealCount") as! Int)"
        cell!.contentLabel!.text = myActivitiesDatasource![indexPath.row].valueForKey("detail") as! String
        cell!.leadName!.text = myActivitiesDatasource![indexPath.row].valueForKey("createUserName") as! String
        
            let timeStamp = NSString(string :myActivitiesDatasource![indexPath.row].valueForKey("startDate") as! String)
        let timeInterval:NSTimeInterval = NSTimeInterval(timeStamp.doubleValue) / 1000
        let startDate = NSDate(timeIntervalSince1970: timeInterval)

        let now = NSDate()
            
        let dtime = startDate.timeIntervalSinceDate(now)
            
            
        cell!.timePart!.firstPart?.text = "\(Int(dtime / 3600))"
        cell!.timePart!.midPart!.text = ":"
        cell!.timePart!.midPart!.font = UIFont(name: "DB LCD Temp", size: UIAdapter.shared.transferHeight(20))
        cell!.timePart!.secondPart!.text = "\(Int(dtime % 3600 / 60))"
            
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
//        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ActivityItemCell
//        cell.backgroundImage!.image = UIImage(named: "activityItem_click")
        
        let soundId = soundPlay!.sound.valueForKey(SoundResource.clickEventSound) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
        
        displayActivityDetail(myActivitiesDatasource![indexPath.row].valueForKey("activityId") as! String)
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView.tag == 2{
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ActivityItemCell
        cell.backgroundImage!.image = UIImage(named: "activityItem")
        }
    }
}