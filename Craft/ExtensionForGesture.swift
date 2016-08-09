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
       self.showDetailWorldChat()
    }
    

    func showDetailWorldChat(){
       self.displayWorldChat = UITapGestureRecognizer(target: self, action: "showDetailWorldChat:")
       self.displayWorldChat!.numberOfTapsRequired = 2
       self.worldChat!.addGestureRecognizer(self.displayWorldChat!)
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
    
    
    func showDetailWorldChat(sender : UITapGestureRecognizer){
        self.showDetailOfWorldChat()
    }
    
    func showTimer(sender : UISwipeGestureRecognizer){
        self.showTimer()
    }
    
    func showActivity(sender : UISwipeGestureRecognizer){
        
        //通过http获取数据
        self.showProgress()
        self.service!.getAllMyActivities("1")
        
    }
    
    func showDaily(sender : UISwipeGestureRecognizer){
       self.showDaily()
    }
    
    func showChat(sender : UISwipeGestureRecognizer){
       self.showChat()
    }
    
    func showDetailOfWorldChat(){
        
        let soundId = soundPlay!.sound.valueForKey(SoundResource.swishinSound) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
        
       self.worldChat!.changeWorldChatState(CGRect(x: UIAdapter.shared.transferWidth(15), y: UIAdapter.shared.transferHeight(120), width: self.view.frame.width - UIAdapter.shared.transferWidth(30), height: self.view.frame.height - (UIAdapter.shared.transferHeight(80))))
        
        if !self.completeState{
            
            self.ovalShapeLayer!.hidden = true
            self.shapeLayer!.hidden = true
            
            UIView.animateWithDuration(0.5, animations: {
//      
                 self.timeView!.joinButton!.frame.origin.y = -UIAdapter.shared.transferHeight(30)
                 self.timeView!.joinButtonBackGround!.frame.origin.y = -UIAdapter.shared.transferHeight(30)
                 self.timeView!.joinButton!.frame.origin.x =  (self.view.frame.width - UIAdapter.shared.transferWidth(80)) / 2 - ((self.view.frame.width - UIAdapter.shared.transferWidth(200)) / 2)
                 self.timeView!.joinButtonBackGround!.frame.origin.x = (self.view.frame.width - UIAdapter.shared.transferWidth(80)) / 2 - ((self.view.frame.width - UIAdapter.shared.transferWidth(200)) / 2)
                 self.timeView!.joinButton!.frame.size = CGSize(width: UIAdapter.shared.transferWidth(80) , height: UIAdapter.shared.transferWidth(80))
                 self.timeView!.joinButtonBackGround!.frame.size = CGSize(width: UIAdapter.shared.transferWidth(80) , height: UIAdapter.shared.transferWidth(80))
                 self.timeView!.joinButtonBackGround!.layer.cornerRadius = UIAdapter.shared.transferWidth(40)
                 self.completeState = !self.completeState
                self.worldChat!.worldChatDetail!.scrollToRowAtIndexPath( NSIndexPath(forRow: self.chatDetail.count - 1  , inSection :0) , atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
            })
        }else{
            UIView.animateWithDuration(0.5, animations: {
                
                   self.timeView!.joinButton?.frame.origin.y = 0
                   self.timeView!.joinButtonBackGround!.frame.origin.y = 0
                   self.timeView!.joinButtonBackGround!.frame.origin.x = 0
                   self.timeView!.joinButton!.frame.origin.x = 0
                   self.timeView!.joinButton!.frame.size = CGSize(width: UIAdapter.shared.transferWidth(200), height: UIAdapter.shared.transferWidth(200))
                   self.timeView!.joinButtonBackGround!.frame.size = CGSize(width: UIAdapter.shared.transferWidth(200), height: UIAdapter.shared.transferWidth(200))
                   self.timeView!.joinButtonBackGround!.layer.cornerRadius = UIAdapter.shared.transferWidth(100)
                
                }, completion: { (success) in
                    self.ovalShapeLayer!.hidden = false
                    self.shapeLayer!.hidden = false
                    
            })
            self.completeState = !self.completeState
            self.worldChat!.worldChatDetail!.scrollToRowAtIndexPath( NSIndexPath(forRow: self.chatDetail.count - 1  , inSection :0) , atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        }
    }
    
    func showTimer(){
        self.worldChat!.worldChatDetail!.reloadData()
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
                
                self.timeView!.frame.origin.y = UIAdapter.shared.transferHeight(80)
                self.worldChat!.frame.origin.y -= self.view.frame.height
                self.activityMainView!.hidden = true
                
                }, completion: nil)
            
             self.setAllInvisable()
             self.timerVisible = true
        }
        
        if self.activityVisible{
            self.disappearActivity(completion)
        }
        if self.chatVisible{
            completion()
        }
        if self.dailyVisible{
            completion()
        }
        
    }
    
    func showActivity(){
        self.activityMainView!.activityTabel?.reloadData()
        
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
            completion()
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
            completion()
        }
    }
    
    func showChat(){
        let soundId = soundPlay!.sound.valueForKey(SoundResource.swishout) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
        
        let completion = {
            let chat = ChatRoom(nibName: nil, bundle: nil)
            chat.sign = self
            let chatNav = UINavigationController(rootViewController: chat)
            chatNav.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
            self.presentViewController(chatNav, animated: false, completion: nil)
            
            self.setAllInvisable()
            self.chatVisible = true
        }
        if self.timerVisible{
            self.disappearTimer(completion)
        }
        if self.activityVisible{
            self.disappearActivity(completion)
        }
        if self.dailyVisible{
           completion()
        }
    }
    
    func disappearTimer(completion : (()->Void)?){
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.timeView!.frame.origin.y = -(self.view.frame.height - UIAdapter.shared.transferWidth(200) - 88 )
            self.worldChat!.frame.origin.y += self.view.frame.height
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
    
    
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        let point = touch.locationInView(gestureRecognizer.view)
        if (CGRectContainsPoint(self.worldChat!.frame, point) || CGRectContainsPoint(self.worldChat!.frame, point) ){
            return false;
        }
        
        return true;
    }

}