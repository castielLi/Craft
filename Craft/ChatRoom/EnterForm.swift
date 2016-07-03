//
//  EnterForm.swift
//  Craft
//
//  Created by castiel on 16/7/3.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class EnterForm: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var backgroundView : UIImageView?
    var sendButton : UIButton?
    var soundButton : UIButton?
    var switchButton : UIButton?
    var enterTextView : UITextView?
    var showEnterTextfield : Bool = true;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 4))
//        backgroundView!.image = UIImage(named: "enterForm")
//        self.addSubview(backgroundView!)
        
        self.layer.cornerRadius = 2
        self.layer.masksToBounds = true
        
        
        self.backgroundColor = UIColor(red: 25/255, green: 31/255, blue: 35/255, alpha: 1)
        
        
        enterTextView = UITextView()
        enterTextView!.layer.cornerRadius = 2
        enterTextView!.layer.masksToBounds = true
        enterTextView?.backgroundColor = UIColor.blackColor()
        enterTextView!.textColor = UIColor.whiteColor()
        enterTextView!.font = UIFont.systemFontOfSize(14)
        enterTextView!.returnKeyType = UIReturnKeyType.Send
        
        
        
        // RT start
//        self.textViewInitialHeight = enterText!.frame.height
//         RT end
        
        self.addSubview(enterTextView!)
        
        self.enterTextView!.mas_makeConstraints{ make in
            make.bottom.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(-2))
            make.left.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(22))
            make.right.equalTo()(self).with().offset()(UIAdapter.shared.transferWidth(-45))
            make.top.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(3))
        }
        
        
        self.switchButton = UIButton(frame:CGRect(x: 0, y: 0, width: UIAdapter.shared.transferHeight(18), height: UIAdapter.shared.transferHeight(18)))
        self.switchButton?.setBackgroundImage(UIImage(named: "switchSound"), forState: UIControlState.Normal)
        self.addSubview(self.switchButton!)
        
        self.switchButton!.mas_makeConstraints{ make in
            make.bottom.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(-2))
            make.left.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(2))
            make.right.equalTo()(self.mas_left).with().offset()(UIAdapter.shared.transferHeight(21))
            make.height.equalTo()(UIAdapter.shared.transferHeight(18))
        }
        
       
        self.sendButton = UIButton(frame:CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(48), height: UIAdapter.shared.transferHeight(18)))
        self.sendButton!.setBackgroundImage(UIImage(named: "sendMessage"), forState: UIControlState.Normal)
        self.addSubview(self.sendButton!)
        
        self.sendButton!.mas_makeConstraints{ make in
            make.bottom.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(-2))
            make.left.equalTo()(self.mas_right).with().offset()(UIAdapter.shared.transferWidth(-43))
            make.right.equalTo()(self).with().offset()(UIAdapter.shared.transferWidth(-2))
            make.height.equalTo()(UIAdapter.shared.transferHeight(18))
        }
        
        self.soundButton = UIButton()
        self.soundButton!.setBackgroundImage(UIImage(named: "sound"), forState: UIControlState.Normal)
        self.addSubview(self.soundButton!)
        
        self.soundButton!.mas_makeConstraints{ make in
            make.bottom.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(-2))
            make.left.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(22))
            make.right.equalTo()(self).with().offset()(UIAdapter.shared.transferWidth(-2))
            make.height.equalTo()(UIAdapter.shared.transferHeight(18))

        }
        
        self.soundButton!.hidden = true;
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
