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
        typeSelected.dataArray = self.typeArray! as [AnyObject]
        typeSelected.displayKey = "apName"
        typeSelected.valueKey = "apCode"
        let Nav = UINavigationController(rootViewController: typeSelected)
        Nav.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        self.presentViewController(Nav, animated: true, completion: nil)
    }
    
    func activitySelected(sender : UITapGestureRecognizer){
        
        let soundId = soundPlay!.sound.valueForKey(SoundResource.swishinSound) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
        
        let typeSelected = OneRollSelection()
        let Nav = UINavigationController(rootViewController: typeSelected)
        Nav.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        self.presentViewController(Nav, animated: true, completion: nil)
    }
    
    func detailSelected(sender: UITapGestureRecognizer){
        let soundId = soundPlay!.sound.valueForKey(SoundResource.swishinSound) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
        
        let typeSelected = OneRollSelection()
        let Nav = UINavigationController(rootViewController: typeSelected)
        Nav.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        self.presentViewController(Nav, animated: true, completion: nil)
    }
}