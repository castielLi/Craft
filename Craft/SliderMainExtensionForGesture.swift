//
//  SliderMainExtensionForGesture.swift
//  Craft
//
//  Created by castiel on 16/5/28.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation

extension SliderMain {
    
    func registerViewsGesture(){
        self.addChatSwipe()
        self.addActivitySwipe()
        self.addTimerSwipe()
    }
    
    func addTimerSwipe(){
        self.showTimerSwipe = UISwipeGestureRecognizer(target: self, action: "showTimer:")
        self.showTimerSwipe!.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(self.showTimerSwipe!)
    }
    
    
    func addActivitySwipe(){
        self.showActivitySwipe = UISwipeGestureRecognizer(target: self, action: "showActivity:")
        self.showActivitySwipe!.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(self.showActivitySwipe!)
    }
    
    func addChatSwipe(){
        self.showChatSwipe = UISwipeGestureRecognizer(target: self, action: "showChat:")
        self.showChatSwipe!.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(self.showChatSwipe!)
    }
    
    func showTimer(sender : UISwipeGestureRecognizer){
        self.disappearDaily(self.sign!.showTimer)
    }
    
    func showActivity(sender : UISwipeGestureRecognizer){
        self.disappearDaily(self.sign!.showActivity)
    }
    
    func showChat(sender : UISwipeGestureRecognizer){
         self.disappearDaily(self.sign!.showChat)
    }
    
    func disappearDaily( completion : (()->Void)?){
        UIView.animateWithDuration(0.5, animations: {
            self.calenderBackground!.alpha = 0
            self.calendar!.alpha = 0
            self.reviewTable!.alpha = 0
        }) { (success) in
            self.dismissViewControllerAnimated(false, completion: nil)
            completion!()
            
        }

    }
    
    
//    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//    
//        
//        return false
//        
//    }

    
}