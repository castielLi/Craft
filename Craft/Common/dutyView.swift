//
//  dutyView.swift
//  Craft
//
//  Created by castiel on 16/5/7.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class dutyView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var tankIcon : UIImageView?
    var damageIcon : UIImageView?
    var healIcon : UIImageView?
    
    var tankLabel : UILabel?
    var damageLabel : UILabel?
    var healLabel : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tankIcon = UIImageView()
        tankIcon!.image = UIImage(named: "tank")
        
        damageIcon = UIImageView()
        damageIcon!.image = UIImage(named: "damage")
        
        healIcon = UIImageView()
        healIcon!.image = UIImage(named: "heal")
        self.addSubview(tankIcon!)
        self.addSubview(damageIcon!)
        self.addSubview(healIcon!)
        
        self.tankIcon!.mas_makeConstraints{ make in
           make.top.equalTo()(self)
           make.left.equalTo()(self).with()
           make.bottom.equalTo()(self.mas_top).with().offset()(UIAdapter.shared.transferHeight(15))
           make.right.equalTo()(self.mas_left).with().offset()(UIAdapter.shared.transferWidth(15))
        }
        
        self.healIcon!.mas_makeConstraints{ make in
            make.top.equalTo()(self)
            make.left.equalTo()(self.mas_right).with().offset()(UIAdapter.shared.transferWidth(-15))
            make.bottom.equalTo()(self.mas_top).with().offset()(UIAdapter.shared.transferHeight(15))
            make.right.equalTo()(self.mas_right)
        }
        
        self.damageIcon!.mas_makeConstraints{ make in
            make.top.equalTo()(self)
            make.centerX.equalTo()(self)
            make.width.equalTo()(UIAdapter.shared.transferWidth(15))
            make.bottom.equalTo()(self.mas_top).with().offset()(UIAdapter.shared.transferHeight(15))
            
        }
        
        tankLabel = UILabel()
        tankLabel?.textAlignment = NSTextAlignment.Center
        tankLabel!.font = UIFont(name: "DB LCD Temp", size: UIAdapter.shared.transferHeight(7))
        tankLabel!.textColor = UIColor.whiteColor()
        self.addSubview(tankLabel!)
        
        damageLabel = UILabel()
        damageLabel?.textAlignment = NSTextAlignment.Center
        damageLabel!.font = UIFont(name: "DB LCD Temp", size: UIAdapter.shared.transferHeight(7))
        damageLabel!.textColor = UIColor.whiteColor()
        self.addSubview(damageLabel!)
        
        healLabel = UILabel()
        healLabel?.textAlignment = NSTextAlignment.Center
        healLabel!.font = UIFont(name: "DB LCD Temp", size: UIAdapter.shared.transferHeight(7))
        healLabel!.textColor = UIColor.whiteColor()
        self.addSubview(healLabel!)
        
        
        self.tankLabel!.mas_makeConstraints{make in
           make.top.equalTo()(self.tankIcon!.mas_bottom).with().offset()(2)
           make.bottom.equalTo()(self)
           make.left.equalTo()(self.tankIcon!)
           make.right.equalTo()(self.tankIcon!)
        }
        
        self.damageLabel!.mas_makeConstraints{make in
            make.top.equalTo()(self.damageIcon!.mas_bottom).with().offset()(2)
            make.bottom.equalTo()(self)
            make.left.equalTo()(self.damageIcon!)
            make.right.equalTo()(self.damageIcon!)
        }
        
        self.healLabel!.mas_makeConstraints{make in
            make.top.equalTo()(self.healIcon!.mas_bottom).with().offset()(2)
            make.bottom.equalTo()(self)
            make.left.equalTo()(self.healIcon!)
            make.right.equalTo()(self.healIcon!)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
