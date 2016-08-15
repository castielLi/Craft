//
//  EventForActivityDetail.swift
//  Craft
//
//  Created by castiel on 16/8/15.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

extension MyActivities{
    
    func showDutyDialog(cell: playerListCell){
        
        let swishinId = self.soundPlay!.sound.valueForKey(SoundResource.swishinSound) as! String
        let swishinid = UInt32(swishinId)
        AudioServicesPlaySystemSound(swishinid!);
        
        let dutyDetail = DutyResponseView()
        weak var currentDutyDetail = dutyDetail
        currentDutyDetail!.Block = {
            
            if (currentDutyDetail!.perfressType == "0"){
                cell.dutyIcon!.setBackgroundImage(UIImage(named: "tank"), forState: UIControlState.Normal)
            }else if (currentDutyDetail!.perfressType == "1"){
                cell.dutyIcon!.setBackgroundImage(UIImage(named: "heal"), forState: UIControlState.Normal)
            }else{
                cell.dutyIcon!.setBackgroundImage(UIImage(named: "damage"), forState: UIControlState.Normal)
            }
            
            let image = ProfessionHelper.getProfressionImage( Int(currentDutyDetail!.perfressType)!, profression: Int(currentDutyDetail!.perfressId)!)
            cell.jobIcon!.setBackgroundImage(image, forState: UIControlState.Normal)
            
            
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
