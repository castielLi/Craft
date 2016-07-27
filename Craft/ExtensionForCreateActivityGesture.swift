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
}