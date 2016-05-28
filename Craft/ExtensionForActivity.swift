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
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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
            //           cell!.timePart!.firstPart!.text = "27"
            //           cell!.timePart!.midPart!.font = UIFont(name: "DINAlternate-Bold", size: UIAdapter.shared.transferHeight(20))
            //           cell!.timePart!.midPart!.text = "days"
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
        
        //        cell!.textLabel?.text = "hello world"
        
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UIAdapter.shared.transferHeight(65)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ActivityItemCell
        cell.backgroundImage!.image = UIImage(named: "activityItem_click")
        
        let soundId = soundPlay!.sound.valueForKey(SoundResource.clickEventSound) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
        
        displayActivityDetail()
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ActivityItemCell
        cell.backgroundImage!.image = UIImage(named: "activityItem")
    }

    //table animation
    //    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    //
    //        var rotation = CATransform3DMakeRotation( CGFloat(0.3 * M_PI) , 0.0, 0.5, 0.0);
    //        rotation.m34 = 1.0 / -600;
    //
    //
    //        //2. Define the initial state (Before the animation)
    //        //        cell.layer.shadowColor = UIColor.blackColor().CGColor
    //        //        cell.layer.shadowOffset = CGSizeMake(10, 10);
    //
    //        cell.layer.transform = rotation;
    //        cell.layer.anchorPoint = CGPointMake(0.5, 0.5);
    //
    //
    //        UIView.beginAnimations("rotation", context: nil)
    //        UIView.setAnimationDuration(0.8)
    //        //3. Define the final state (After the animation) and commit the animation
    //        cell.layer.transform = CATransform3DIdentity;
    //        cell.alpha = 1;
    //        cell.layer.shadowOffset = CGSizeMake(0, 0);
    //        UIView.commitAnimations()
    //    }
}