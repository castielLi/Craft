//
//  ExtensionForCreateActivityGesture.swift
//  Craft
//
//  Created by castiel on 16/7/20.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation

extension AddNewActivityController {
    
    func addGestureForDropdowns(){
         self.typeDropDownTap = UITapGestureRecognizer(target: self, action: "typeSelected:")
         self.typeDropDownTap!.numberOfTapsRequired = 1
         self.typeSelected!.addGestureRecognizer(self.typeDropDownTap!)
        
         self.activityDropDownTap = UITapGestureRecognizer(target: self, action: "activitySelected:")
         self.activityDropDownTap!.numberOfTapsRequired = 1
         self.activitySelected!.addGestureRecognizer(self.activityDropDownTap!)
        
         self.detailDropDownTap = UITapGestureRecognizer(target: self, action: "detailSelected:")
         self.detailDropDownTap!.numberOfTapsRequired = 1
         self.detailSelected!.addGestureRecognizer(detailDropDownTap!)
    }
    
    func typeSelected(sender : UITapGestureRecognizer){
        
        let soundId = soundPlay!.sound.valueForKey(SoundResource.swishinSound) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
        
        let typeSelected = OneRollSelection()
        weak var currentTypeSelected = typeSelected
        currentTypeSelected!.Block = {
           self.typeSelected!.displayLabel!.text = currentTypeSelected!.key
           self.typeSelectedValue = currentTypeSelected!.value
           self.initActivityData(self.typeSelectedValue!)
        }
        currentTypeSelected!.dataArray = self.typeArray! as [AnyObject]
        currentTypeSelected!.displayKey = "apName"
        currentTypeSelected!.valueKey = "apCode"
        let Nav = UINavigationController(rootViewController: currentTypeSelected!)
        Nav.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        self.presentViewController(Nav, animated: true, completion: nil)
    }
    
    func activitySelected(sender : UITapGestureRecognizer){
        let soundId = soundPlay!.sound.valueForKey(SoundResource.swishinSound) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
        
        let activitySelected = OneRollSelection()
         weak var currentActivitySelected = activitySelected
        currentActivitySelected!.dataArray = self.activityArray! as [AnyObject]
        currentActivitySelected!.displayKey = "apdName"
        currentActivitySelected!.valueKey = "apdCode"
        currentActivitySelected!.Block = {
            self.activitySelected!.displayLabel!.text = currentActivitySelected!.key
            self.activitySelectedValue = currentActivitySelected!.value
            self.initLevelData(self.activitySelectedValue!)
        }
        let Nav = UINavigationController(rootViewController: currentActivitySelected!)
        Nav.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        self.presentViewController(Nav, animated: true, completion: nil)
    }
    
    func detailSelected(sender: UITapGestureRecognizer){
        let soundId = soundPlay!.sound.valueForKey(SoundResource.swishinSound) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
        
        let levelSelected = OneRollSelection()
        weak var currentLevelSelected = levelSelected
        currentLevelSelected!.dataArray = self.levelArray! as [AnyObject]
        currentLevelSelected!.displayKey = "aplName"
        currentLevelSelected!.valueKey = "aplCode"
        currentLevelSelected!.Block = {
            self.detailSelected!.displayLabel!.text = currentLevelSelected!.key
            self.detailSelectedValue = currentLevelSelected!.value
        }

        let Nav = UINavigationController(rootViewController: currentLevelSelected!)
        Nav.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        self.presentViewController(Nav, animated: true, completion: nil)
    }
    
    func addTimeTapGesture(){
        timeTap = UITapGestureRecognizer(target: self, action: "timeViewDidTap:")
        timeTap!.numberOfTapsRequired = 1
        self.timeView!.addGestureRecognizer(timeTap!)
    }
    
    func timeViewDidTap(sender : UITapGestureRecognizer){
        

        UIView.animateWithDuration(0.4, animations: {
            
            self.activitiesView!.frame.origin.x = -UIAdapter.shared.transferWidth(300)
            self.activityMain!.frame.origin.x = -UIAdapter.shared.transferWidth(270)
            self.cancelButton!.frame.origin.x = -UIAdapter.shared.transferWidth(140)
            self.createButton!.frame.origin.x = -UIAdapter.shared.transferWidth(270)
            
            })
        { (success) in
            
            let swishinId = self.soundPlay!.sound.valueForKey(SoundResource.swishinSound) as! String
            let swishinid = UInt32(swishinId)
            AudioServicesPlaySystemSound(swishinid!);
            
            let timeDetail = TwoRollSelection()
            weak var currentTimeDetail = timeDetail
            currentTimeDetail!.currentMonth = self.timeView!.month!
            currentTimeDetail!.currentDay = self.timeView!.day!
            currentTimeDetail!.currentHour = self.timeView!.month!
            currentTimeDetail!.currentYear = self.timeView!.year!
            currentTimeDetail!.currentMinute = self.timeView!.minutes!
            currentTimeDetail!.Block = {
                UIView.animateWithDuration(0.4, animations: {
                    
                    let swishinId = self.soundPlay!.sound.valueForKey(SoundResource.swishinSound) as! String
                    let swishinid = UInt32(swishinId)
                    AudioServicesPlaySystemSound(swishinid!);
                    
                    self.year = currentTimeDetail!.year
                    self.month = currentTimeDetail!.month
                    self.day = currentTimeDetail!.day
                    self.beginHour = currentTimeDetail!.beginHour
                    self.beginMin = currentTimeDetail!.beginMinute
                    self.endHour = currentTimeDetail!.endHour
                    self.endMin = currentTimeDetail!.endMinute
                    
                    self.timeView!.startTime!.date!.text = "\(self.month!)月\(self.day!)日"
                    self.timeView!.endTime!.date!.text = "\(self.month!)月\(self.day!)日"
                    
                    self.timeView!.startTime!.time!.text = "\(self.beginHour!):\(self.beginMin!)"
                    self.timeView!.endTime!.time!.text = "\(self.endHour!):\(self.endMin!)"
                    
                    self.activitiesView!.frame.origin.x += UIAdapter.shared.transferWidth(300)
                    self.activityMain!.frame.origin.x += UIAdapter.shared.transferWidth(300)
                    self.cancelButton!.frame.origin.x += UIAdapter.shared.transferWidth(300)
                    self.createButton!.frame.origin.x += UIAdapter.shared.transferWidth(300)
                    
                })
            }
            
            let Nav = UINavigationController(rootViewController: currentTimeDetail!)
            Nav.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
            self.presentViewController(Nav, animated: true, completion: nil)
        }
        
        
    }
    
    func addSelfDutyGesture(){
       self.selfDutyInfoTap = UITapGestureRecognizer(target: self, action: "selfDutyTap:")
       self.selfDutyInfoTap!.numberOfTapsRequired = 1
       self.currentUserInfo!.addGestureRecognizer(self.selfDutyInfoTap!)
    }
    
    
    func selfDutyTap(sender : UITapGestureRecognizer){
        let swishinId = self.soundPlay!.sound.valueForKey(SoundResource.swishinSound) as! String
        let swishinid = UInt32(swishinId)
        AudioServicesPlaySystemSound(swishinid!);
        
        let dutyDetail = DutyResponseView()
        weak var currentDutyDetail = dutyDetail
        currentDutyDetail!.Block = {
            
            if (currentDutyDetail!.perfressType == "0"){
                self.currentUserInfo!.duty!.image = UIImage(named: "tank")
            }else if (currentDutyDetail!.perfressType == "1"){
                 self.currentUserInfo!.duty!.image = UIImage(named: "heal")
            }else{
                self.currentUserInfo!.duty!.image = UIImage(named: "damage")
            }
            
            self.currentUserInfo!.job!.image = ProfessionHelper.getProfressionImage( Int(currentDutyDetail!.perfressType)!, profression: Int(currentDutyDetail!.perfressId)!)
            
            
            UIView.animateWithDuration(0.4, animations: {
                
                let swishinId = self.soundPlay!.sound.valueForKey(SoundResource.swishinSound) as! String
                let swishinid = UInt32(swishinId)
                AudioServicesPlaySystemSound(swishinid!);
                
            })
        }
        
        let Nav = UINavigationController(rootViewController: currentDutyDetail!)
        Nav.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        self.presentViewController(Nav, animated: true, completion: nil)
    }
}