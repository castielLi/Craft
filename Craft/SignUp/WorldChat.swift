//
//  WorldChat.swift
//  Craft
//
//  Created by castiel on 16/6/21.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class WorldChat: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var background : UIImageView?
    var chatView: UITableView?
    var enterText : UITextView?
    var enterForm : UIView?
    var sendButton : UIButton?
    var completeState : Bool = false
    var smallBackground : UIView?
    var initSize : CGRect?
    
    var worldChatDetail : UITableView?
    
    
    var tribeButton : UIButton?
    var allianceButton : UIButton?
    var raidButton : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSize = frame
        
        let beffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        self.smallBackground = UIVisualEffectView(effect: beffect)
        
        smallBackground!.frame = self.bounds
        self.addSubview(self.smallBackground!)
        
        self.background = UIImageView(frame: frame)
        
        let path = NSBundle.mainBundle().pathForResource("worldChatCompleteState", ofType: "png")
        self.background!.image = UIImage(contentsOfFile: path!)
        self.background!.hidden = true
        self.background!.alpha = 0.5
        self.addSubview(self.background!)
        
        
        
        self.worldChatDetail = UITableView(frame: CGRect(x: UIAdapter.shared.transferWidth(3), y: UIAdapter.shared.transferHeight(3), width: self.frame.width - UIAdapter.shared.transferWidth(6), height: self.frame.height - UIAdapter.shared.transferHeight(18 + 28)))
        self.worldChatDetail?.backgroundColor = UIColor.clearColor()
        self.worldChatDetail!.separatorStyle = UITableViewCellSeparatorStyle.None
        self.addSubview(worldChatDetail!)
        
        
        
        self.enterForm = UIView(frame: CGRect(x: UIAdapter.shared.transferWidth(3), y: self.frame.height - UIAdapter.shared.transferHeight(25), width: self.frame.width - UIAdapter.shared.transferWidth(6), height: UIAdapter.shared.transferHeight(25)))
        self.enterForm?.backgroundColor = UIColor(red: 25/255, green: 31/255, blue: 35/255, alpha: 1)
        self.addSubview(enterForm!)
        
        enterText = UITextView()
        enterText!.layer.cornerRadius = 2
        enterText!.layer.masksToBounds = true
        enterText?.backgroundColor = UIColor.blackColor()
        enterText!.textColor = UIColor.whiteColor()
        enterText!.font = UIFont.systemFontOfSize(14)
        enterText!.returnKeyType = UIReturnKeyType.Send
        self.addSubview(enterText!)
        
        self.enterText!.mas_makeConstraints{ make in
           make.top.equalTo()(self.enterForm!.mas_top).with().offset()(UIAdapter.shared.transferHeight(3))
           make.bottom.equalTo()(self.enterForm!).with().offset()(UIAdapter.shared.transferHeight(-3))
           make.left.equalTo()(self.enterForm!).with().offset()(UIAdapter.shared.transferWidth(5))
           make.right.equalTo()(self.enterForm!).with().offset()(UIAdapter.shared.transferWidth(-50))
        }
        
        
        self.sendButton = UIButton()
        self.sendButton!.setBackgroundImage(UIImage(named: "sendMessage"), forState: UIControlState.Normal)
        self.addSubview(self.sendButton!)
        
        self.sendButton!.mas_makeConstraints{ make in
            make.bottom.equalTo()(self.enterText!)
            make.left.equalTo()(self.enterText!.mas_right).with().offset()(UIAdapter.shared.transferWidth(2))
            make.right.equalTo()(self.enterForm!.mas_right).with().offset()(UIAdapter.shared.transferWidth(-5))
            make.height.equalTo()(UIAdapter.shared.transferHeight(19))
        }
        
        self.allianceButton = UIButton()
        self.allianceButton!.tag = 100
        self.allianceButton!.setBackgroundImage(UIImage(named: "allianceButton"), forState: UIControlState.Normal)
        self.addSubview(self.allianceButton!)
        
        self.allianceButton!.mas_makeConstraints{ make in
           make.bottom.equalTo()(self.enterForm!.mas_top)
           make.left.equalTo()(self.enterForm!)
           make.height.equalTo()(UIAdapter.shared.transferHeight(18))
           make.width.equalTo()(UIAdapter.shared.transferWidth(30))
        }
        
        self.tribeButton = UIButton()
        self.allianceButton!.tag = 101
        self.tribeButton!.setBackgroundImage(UIImage(named: "tribeButton"), forState: UIControlState.Normal)
        self.addSubview(self.tribeButton!)
        
        self.tribeButton!.mas_makeConstraints{ make in
            make.bottom.equalTo()(self.enterForm!.mas_top)
            make.left.equalTo()(self.enterForm!).with().offset()(UIAdapter.shared.transferWidth(30))
            make.height.equalTo()(UIAdapter.shared.transferHeight(18))
            make.width.equalTo()(UIAdapter.shared.transferWidth(30))
        }
        
        self.raidButton = UIButton()
        self.allianceButton!.tag = 102
        self.raidButton!.setBackgroundImage(UIImage(named: "raidButton"), forState: UIControlState.Normal)
        self.addSubview(self.raidButton!)
        
        self.raidButton!.mas_makeConstraints{ make in
            make.bottom.equalTo()(self.enterForm!.mas_top)
            make.left.equalTo()(self.enterForm!).with().offset()(UIAdapter.shared.transferWidth(60))
            make.height.equalTo()(UIAdapter.shared.transferHeight(18))
            make.width.equalTo()(UIAdapter.shared.transferWidth(30))
        }
        
        

    }
    
    func changeWorldChatState(completeFrame : CGRect?){
        if !completeState {

            self.background!.hidden = false;
            
            self.background!.frame =  CGRect(x: 0, y: UIAdapter.shared.transferWidth(-60), width: completeFrame!.width , height: completeFrame!.height)
            UIView.animateWithDuration(0.5, animations: {
                    self.frame = completeFrame!
                    self.smallBackground!.alpha = 0.5
                    self.background!.alpha = 1
                
                    self.enterForm!.frame.origin.y = completeFrame!.size.height - UIAdapter.shared.transferHeight(60) - self.enterForm!.frame.height
                    self.enterText!.frame.origin.y = completeFrame!.size.height - UIAdapter.shared.transferHeight(60)
                - self.enterForm!.frame.height + UIAdapter.shared.transferHeight(3)
                    self.sendButton!.frame.origin.y = completeFrame!.size.height - UIAdapter.shared.transferHeight(60)
                -self.enterForm!.frame.height + UIAdapter.shared.transferHeight(3)
                
                    self.worldChatDetail!.frame = CGRect(x: UIAdapter.shared.transferWidth(5), y: UIAdapter.shared.transferHeight(5), width: completeFrame!.size.width - UIAdapter.shared.transferWidth(10), height: completeFrame!.size.height - UIAdapter.shared.transferHeight(52 + 18 + 35))
                } ,completion: { (success) in
                    self.smallBackground!.hidden = true;
                })

            
        }else{

            self.smallBackground!.hidden = false;
            
            self.smallBackground!.frame = CGRect(x: 0, y: 0 , width: self.initSize!.width , height: self.initSize!.height)
            UIView.animateWithDuration(0.5, animations: {
                     self.frame = self.initSize!
                     self.background!.alpha = 0.5
                     self.smallBackground!.alpha = 1
                
                self.enterForm!.frame.origin.y = self.initSize!.size.height - self.enterForm!.frame.height
                self.enterText!.frame.origin.y = self.initSize!.size.height - self.enterForm!.frame.height + UIAdapter.shared.transferHeight(3)
                self.sendButton!.frame.origin.y = self.initSize!.size.height - self.enterForm!.frame.height + UIAdapter.shared.transferHeight(3)
                
                self.worldChatDetail!.frame = (frame: CGRect(x: UIAdapter.shared.transferWidth(3), y: UIAdapter.shared.transferHeight(3), width: self.frame.width - UIAdapter.shared.transferWidth(6), height: self.frame.height - UIAdapter.shared.transferHeight(18 + 28)))
                },completion: { (success) in
                     self.background!.hidden = true;
                })
           

            
        }
        self.completeState = !self.completeState
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
