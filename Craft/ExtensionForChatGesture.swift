//
//  ExtensionForChatGesture.swift
//  Craft
//
//  Created by castiel on 16/5/29.
//  Copyright © 2016年 castiel. All rights reserved.
//

import Foundation

extension ChatRoom : UIGestureRecognizerDelegate{
    
    func registerViewsGesture(){
        self.addDailySwipe()
        self.addActivitySwipe()
        self.addTimerSwipe()
        self.addBlankTap()
        self.addChatSwipe()
        self.addDoubleClick()
    }
    
    func addChatSwipe(){
        self.showChatList = UISwipeGestureRecognizer(target: self, action: "showChatList:")
        self.showChatList!.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(self.showChatList!)
    }
    
    func addDoubleClick(){
        self.chatListDoubleTap = UITapGestureRecognizer(target: self, action: "blankTap:")
        self.chatListDoubleTap?.numberOfTapsRequired = 2
        self.selectDialog!.addGestureRecognizer(chatListDoubleTap!)
    }
    
    func addBlankTap(){
       self.tapblank = UITapGestureRecognizer(target: self, action: "blankTap:")
       self.tapblank?.numberOfTapsRequired = 1
       self.tapblank!.delegate = self
       self.view.addGestureRecognizer(tapblank!)
    }
    
    func addTimerSwipe(){
        self.showTimerSwipe = UISwipeGestureRecognizer(target: self, action: "showTimer:")
        self.showTimerSwipe!.direction = UISwipeGestureRecognizerDirection.Down
        self.showTimerSwipe!.delegate = self
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
        self.showDailySwipe!.delegate = self
        self.view.addGestureRecognizer(self.showDailySwipe!)
    }
    
    func blankTap(sender : UITapGestureRecognizer){
        self.hideDetailAndShowList()
    }
    
    func showChatList(sender : UISwipeGestureRecognizer){
        self.hideDetailAndShowList()
    }
    
    func showTimer(sender : UISwipeGestureRecognizer){
        self.disappearChat(self.sign!.showTimer)
    }
    
    func showActivity(sender : UISwipeGestureRecognizer){
        self.disappearChat(self.sign!.showActivity)
    }
    
    func showDaily(sender : UISwipeGestureRecognizer){
        self.disappearChat(self.sign!.showDaily)
    }
    
    func disappearChat( completion : (()->Void)?){
        UIView.animateWithDuration(0.5, animations: {
            self.selectDialog!.frame.origin.x = self.view.frame.width
            self.chatDetailView!.frame.origin.x = -UIAdapter.shared.transferWidth(235)
            self.detailTable!.frame.origin.x = -UIAdapter.shared.transferWidth(210)
            self.enterForm!.frame.origin.x = -UIAdapter.shared.transferWidth(235)
        }) { (success) in
            self.dismissViewControllerAnimated(false, completion: nil)
            completion!()
            
        }
    }
    
    private func hideDetailAndShowList(){
       if self.chatDetailView!.frame.origin.x >= 0{
          UIView.animateWithDuration(0.3, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.selectDialog!.frame.origin.x -= UIAdapter.shared.transferWidth(220)
            }, completion: nil)
        
        UIView.animateWithDuration(0.4, animations: {
            self.chatDetailView!.frame.origin.x = -UIAdapter.shared.transferWidth(235)
            self.enterForm!.frame.origin.x = -UIAdapter.shared.transferWidth(235)
//            self.buttonSend!.frame.origin.x = -UIAdapter.shared.transferWidth(50)
            self.detailTable!.frame.origin.x = -UIAdapter.shared.transferWidth(210)
        })
      }
    
       self.enterForm!.enterTextView!.resignFirstResponder()
//       self.searchText!.resignFirstResponder()

    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        let point = touch.locationInView(gestureRecognizer.view)
        if (CGRectContainsPoint(self.chatDetailView!.frame, point) || CGRectContainsPoint(self.selectDialog!.frame, point) ){
            self.enterForm!.enterTextView!.resignFirstResponder()
            return false;
        }
        
        return true;
    }
    
}