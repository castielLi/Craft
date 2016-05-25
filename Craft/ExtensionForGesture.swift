//
//  ExtensionForGesture.swift
//  Craft
//
//  Created by castiel on 16/3/26.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation

extension SignUp : UIGestureRecognizerDelegate{
   
    func addTimerSwipe(){
        self.disappearTimerSwipe = UISwipeGestureRecognizer(target: self, action: "disappearTimer:")
        self.disappearTimerSwipe!.direction = UISwipeGestureRecognizerDirection.Down
        self.disappearTimerSwipe!.delegate = self
        self.view.addGestureRecognizer(self.disappearTimerSwipe!)
    }
    
    func disappearTimer(sender : UISwipeGestureRecognizer){
        self.displayTimer()
    }
    
    func addActivitySwipe(){
        self.disappearActivitySwipe = UISwipeGestureRecognizer(target: self, action: "disappearActivity:")
        self.disappearActivitySwipe!.direction = UISwipeGestureRecognizerDirection.Left
        self.disappearActivitySwipe!.delegate = self
        self.view.addGestureRecognizer(self.disappearActivitySwipe!)
    }
    
    func disappearActivity(sender : UISwipeGestureRecognizer){
       self.displayActivity()
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UISwipeGestureRecognizer{
            
            if self.view.frame.origin.x > 0 || self.activityMainView!.frame.origin.x > 0{
               return false
            }
            return true
        } else {
            return false
        }
    }

}