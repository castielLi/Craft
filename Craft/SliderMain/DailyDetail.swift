//
//  DailyDetail.swift
//  Craft
//
//  Created by castiel on 16/5/26.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class DailyDetail: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var duty : dailyDutyView?
    var iconImage : UIImageView?
    var occupation : UIImageView?
    var raidName : UILabel?
    var time : Time?
    var content : UILabel?
    var detailButton : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        iconImage = UIImageView()
        iconImage!.image = UIImage(named: "challenge")
        self.addSubview(iconImage!)
        
        self.iconImage!.mas_makeConstraints{ make in
           make.top.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(20))
           make.left.equalTo()(self).with().offset()(UIAdapter.shared.transferWidth(40))
           make.height.equalTo()(UIAdapter.shared.transferHeight(50))
           make.width.equalTo()(UIAdapter.shared.transferWidth(45))
        }
        
        raidName = UILabel()
        self.raidName!.textColor = UIColor.whiteColor()
        raidName!.text = "纳克萨玛斯";
        raidName!.textAlignment = NSTextAlignment.Center
        raidName!.font = UIFont(name: "KaiTi", size: 18)
        self.addSubview(self.raidName!)
        
        self.raidName!.mas_makeConstraints{ make in
          make.top.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(22))
          make.bottom.equalTo()(self.mas_top).with().offset()(UIAdapter.shared.transferHeight(45))
          make.left.equalTo()(self.iconImage!.mas_right).with().offset()(UIAdapter.shared.transferWidth(5))
          make.width.equalTo()( self.frame.width - 80 - UIAdapter.shared.transferWidth(110) )
        }
        
        occupation = UIImageView()
        occupation!.image = UIImage(named: "dz")
        self.addSubview(occupation!)
        
        self.occupation!.mas_makeConstraints{ make in
            make.top.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(30))
            make.right.equalTo()(self).with().offset()(UIAdapter.shared.transferWidth(-40))
            make.height.equalTo()(UIAdapter.shared.transferWidth(40))
            make.width.equalTo()(UIAdapter.shared.transferWidth(40))
        }
        
        
        time = Time()
        self.addSubview(self.time!)
        
        time!.firstPart!.text = "09";
        time!.secondPart!.text = "48";
        time!.midPart!.text = ":";
        
        self.time!.mas_makeConstraints{ make in
            make.top.equalTo()(self.raidName!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(3))
            make.bottom.equalTo()(self.raidName!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(26))
            make.left.equalTo()(self.iconImage!.mas_right).with().offset()(UIAdapter.shared.transferWidth(13))
            make.width.equalTo()( self.frame.width - 80 - UIAdapter.shared.transferWidth(110) )
        }
        
        duty = dailyDutyView()
        self.addSubview(duty!)
        
        self.duty!.tankLabel!.text = "3"
        self.duty!.damageLabel!.text = "15"
        self.duty!.healLabel!.text = "4"
        
        self.duty!.mas_makeConstraints{ make in
            make.top.equalTo()(self.iconImage!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(5))
            make.height.equalTo()(UIAdapter.shared.transferHeight(65))
            make.left.equalTo()(self.iconImage!).with().offset()(UIAdapter.shared.transferWidth(10))
            make.right.equalTo()( self.occupation!).with().offset()(UIAdapter.shared.transferWidth(-10))
        }
        
        
        content = UILabel()
        self.content!.textColor = UIColor.whiteColor()
        content!.text = "始于: 2016年5月3日 20:00";
        content!.textColor = Resources.Color.dailyColor;
        content!.textAlignment = NSTextAlignment.Center
        content!.font = UIFont.systemFontOfSize(13)
        self.addSubview(self.content!)
        
        self.content!.mas_makeConstraints{ make in
            make.top.equalTo()(self.duty!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(5))
            make.bottom.equalTo()(self.duty!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(15))
            make.left.equalTo()(self)
            make.right.equalTo()(self)
        }
        
        detailButton = UIButton()
        detailButton!.setImage(UIImage(named: "dailyDetail"), forState: UIControlState.Normal)
        self.addSubview(detailButton!)
        
        self.detailButton!.mas_makeConstraints{ make in
            make.top.equalTo()(self.content!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(15))
            make.height.equalTo()(UIAdapter.shared.transferHeight(27))
            make.width.equalTo()(UIAdapter.shared.transferWidth(100))
            make.centerX.equalTo()(self)

        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
