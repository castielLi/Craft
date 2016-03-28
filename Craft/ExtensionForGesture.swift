//
//  ExtensionForGesture.swift
//  Craft
//
//  Created by castiel on 16/3/26.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation

extension SignUp{
   
    func addTimerSwipe(){
        self.disappearTimerSwipe = UISwipeGestureRecognizer(target: self, action: "disappearTimer:")
        self.disappearTimerSwipe!.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(self.disappearTimerSwipe!)
    }
    
    func disappearTimer(sender : UISwipeGestureRecognizer){
        self.displayTimer()
    }
    
    func addActivitySwipe(){
        self.disappearTimerSwipe = UISwipeGestureRecognizer(target: self, action: "disappearActivity:")
        self.disappearTimerSwipe!.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(self.disappearTimerSwipe!)
    }
    
    func disappearActivity(sender : UISwipeGestureRecognizer){
       self.displayActivity()
    }

}