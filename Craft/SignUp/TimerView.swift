//
//  TimerView.swift
//  Craft
//
//  Created by castiel on 16/3/26.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class TimerView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var joinButton : UIButton?
    var joinButtonBackGround : UIImageView?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.joinButtonBackGround = UIImageView(frame: CGRectMake(0,
            0 ,UIAdapter.shared.transferWidth(200), UIAdapter.shared.transferWidth(200)))
        self.joinButtonBackGround!.layer.masksToBounds = true
        self.joinButtonBackGround!.layer.cornerRadius = UIAdapter.shared.transferWidth(100)
        
        
//        let beffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
//        let view = UIVisualEffectView(effect: beffect)
//        
//        view.frame = self.joinButtonBackGround!.bounds
//        self.joinButtonBackGround!.addSubview(view)
        self.addSubview(self.joinButtonBackGround!)
        
        self.joinButtonBackGround!.image = UIImage(named: "signupBack")
        
        self.joinButton = UIButton(frame: CGRectMake(0,
            0,UIAdapter.shared.transferWidth(200), UIAdapter.shared.transferWidth(200)))
        self.joinButton!.layer.masksToBounds = true
        self.joinButton!.layer.cornerRadius = UIAdapter.shared.transferWidth(100)
        self.addSubview(self.joinButton!)
        
//        self.joinButton!.addTarget(self, action: "joinButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.joinButton!.alpha = 0.9
        
    }
    
    
//    func joinButtonClick(sender : UIButton){
//        for layer in self.joinButton!.layer.sublayers!{
//            layer.removeFromSuperlayer()
//        }
//        setCircleRing()
//        setAnimationLayer()
//        
//        let date = NSDate().dateByAddingTimeInterval(5)
//        let note = LocalNotification(title: "地狱火堡垒", deadLine: date )
//        SendNotification.SendLocalNotifation(note)
//    }

    
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
