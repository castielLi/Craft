//
//  ExtensionForGesture.swift
//  Craft
//
//  Created by castiel on 16/3/26.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation

extension SignUp{

    func registerGesture(){
       self.addChatSwipe()
       self.addDailySwipe()
       self.addTimerSwipe()
       self.addActivitySwipe()
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
    
    
    func addDailySwipe(){
        self.showDailySwipe = UISwipeGestureRecognizer(target: self, action: "showDaily:")
        self.showDailySwipe!.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(self.showDailySwipe!)
    }
    
    func addChatSwipe(){
        self.showChatSwipe = UISwipeGestureRecognizer(target: self, action: "showChat:")
        self.showChatSwipe!.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(self.showChatSwipe!)
    }
    
    
    func showTimer(sender : UISwipeGestureRecognizer){
        self.showTimer()
    }
    
    func showActivity(sender : UISwipeGestureRecognizer){
        self.showActivity()
    }
    
    func showDaily(sender : UISwipeGestureRecognizer){
       self.showDaily()
    }
    
    func showChat(sender : UISwipeGestureRecognizer){
       self.showChat()
    }
    
    func showTimer(){
        if timeView!.frame.origin.y < 0{
            
            let yAnimation = CABasicAnimation(keyPath: "position.y")
            yAnimation.toValue = self.view!.frame.size.height / 2
            yAnimation.fromValue = -self.view!.frame.size.height / 2
            yAnimation.duration = 0.1
            yAnimation.delegate = self
            bloodBackGroundImage!.layer.addAnimation(yAnimation, forKey: "blood")
    
            
        let soundId = soundPlay!.sound.valueForKey(SoundResource.swishout) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
        }
        
        
        let completion = {
            UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 100, initialSpringVelocity: 18, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                
                self.timeView!.frame.origin.y = self.view.frame.height - UIAdapter.shared.transferWidth(200) - 88
                self.activityMainView!.hidden = true
                
                }, completion: nil)
            
             self.setAllInvisable()
             self.timerVisible = true
        }
        
        if self.activityVisible{
            self.disappearActivity(completion)
        }
        if self.chatVisible{
            self.disappearChat(completion)
        }
        if self.dailyVisible{
            completion()
        }
        
    }
    
    
    func showActivity(){
        
        if self.activityMainView!.frame.origin.x < 0{
            let soundId = soundPlay!.sound.valueForKey(SoundResource.swishout) as! String
            let id = UInt32(soundId)
            AudioServicesPlaySystemSound(id!);
        }
        
        let completion = {
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 100, initialSpringVelocity: 5, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                
                self.activityMainView!.hidden = false
                self.activityMainView!.frame.origin.x = 0
                
                }, completion: nil)
            self.setAllInvisable()
            self.activityVisible = true
        }
        
        if self.timerVisible{
            self.disappearTimer(completion)
        }
        if self.chatVisible{
            self.disappearChat(completion)
        }
        if self.dailyVisible{
           completion()
        }
        
    }
    
    func showDaily(){
        let yAnimation = CABasicAnimation(keyPath: "position.y")
        yAnimation.toValue = -self.view!.frame.size.height / 2
        yAnimation.fromValue = self.view!.frame.size.height / 2
        yAnimation.duration = 0.2
        yAnimation.repeatCount = 1
        yAnimation.delegate = self
        bloodBackGroundImage!.layer.addAnimation(yAnimation, forKey: "blood")
        
        let soundId = soundPlay!.sound.valueForKey(SoundResource.swishout) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
        
        let completion = {
            let daily = SliderMain(nibName: nil, bundle: nil)
            daily.sign = self
            let dailyNav = UINavigationController(rootViewController: daily)
            dailyNav.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
            self.presentViewController(dailyNav, animated: false, completion: nil)
            
            self.setAllInvisable()
            self.dailyVisible = true
        }
        if self.timerVisible{
            self.disappearTimer(completion)
        }
        if self.activityVisible{
           self.disappearActivity(completion)
        }
        if self.chatVisible{
           self.disappearChat(completion)
        }
    }
    
    func showChat(){
    
    }
    
    func disappearTimer(completion : (()->Void)?){
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.timeView!.frame.origin.y = -(self.view.frame.height - UIAdapter.shared.transferWidth(200) - 88 )
            
        }) { (success) -> Void in
            if success {
                completion!()
            }
        }

    }
    
    func disappearActivity(completion : (()->Void)?){
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.activityMainView!.frame.origin.x = -UIAdapter.shared.transferWidth(290)
            
        }) { (success) -> Void in
            if success {
                completion!()
            }
        }
    }
    
    func disappearChat(completion: (()->Void)?){
        completion!()
    }
    
    func setAllInvisable(){
        self.dailyVisible = false
        self.timerVisible = false
        self.chatVisible = false
        self.activityVisible = false
    }
    
    func getBloodAnimation() ->CAAnimation?{
        let animation = self.bloodBackGroundImage!.layer.animationForKey("blood")
        return animation
    }

}