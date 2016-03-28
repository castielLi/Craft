//
//  RightMenu.swift
//  Craft
//
//  Created by castiel on 16/3/28.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class RightMenu: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var chatRoom : UIButton?
    var setting : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let beffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let view = UIVisualEffectView(effect: beffect)
        view.frame = self.bounds
        self.addSubview(view)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        chatRoom = UIButton()
        chatRoom!.setBackgroundImage(UIImage(named: "Chat"), forState: UIControlState.Normal)
        self.addSubview(chatRoom!)
        
        self.chatRoom!.mas_makeConstraints{ make in
          make.left.equalTo()(self).with().offset()(UIAdapter.shared.transferWidth(2))
          make.right.equalTo()(self).with().offset()(UIAdapter.shared.transferWidth(-2))
          make.bottom.equalTo()(self).with().offset()( -((self.frame.height / 2) + UIAdapter.shared.transferHeight(5)) )
          make.height.equalTo()(UIAdapter.shared.transferHeight(20))
        }
        
        setting = UIButton()
        setting!.setBackgroundImage(UIImage(named: "Chat"), forState: UIControlState.Normal)
        self.addSubview(setting!)
        
        self.setting!.mas_makeConstraints{ make in
            make.left.equalTo()(self).with().offset()(UIAdapter.shared.transferWidth(2))
            make.right.equalTo()(self).with().offset()(UIAdapter.shared.transferWidth(-2))
            make.top.equalTo()(self).with().offset()((self.frame.height / 2) + UIAdapter.shared.transferHeight(5))
            make.height.equalTo()(UIAdapter.shared.transferHeight(20))
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
