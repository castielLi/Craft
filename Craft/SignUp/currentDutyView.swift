//
//  currentDutyView.swift
//  Craft
//
//  Created by castiel on 16/7/10.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class currentDutyView: UIView {

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
        
        tankIcon = UIImageView(frame:CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(30), height: UIAdapter.shared.transferHeight(30)))
        tankIcon!.image = UIImage(named: "tank")
        
        damageIcon = UIImageView(frame:CGRect(x: UIAdapter.shared.transferWidth(30 + 30), y: 0, width: UIAdapter.shared.transferWidth(30), height: UIAdapter.shared.transferHeight(30)))
        damageIcon!.image = UIImage(named: "damage")
        
        healIcon = UIImageView((frame:CGRect(x: UIAdapter.shared.transferWidth(60 + 60), y: 0, width: UIAdapter.shared.transferWidth(30), height: UIAdapter.shared.transferHeight(30))))
        healIcon!.image = UIImage(named: "heal")
        self.addSubview(tankIcon!)
        self.addSubview(damageIcon!)
        self.addSubview(healIcon!)

        
        tankLabel = UILabel()
        tankLabel?.textAlignment = NSTextAlignment.Center
        tankLabel!.font = UIFont(name: "DB LCD Temp", size: UIAdapter.shared.transferHeight(10))
        tankLabel!.textColor = UIColor.whiteColor()
        self.addSubview(tankLabel!)
        
        damageLabel = UILabel()
        damageLabel?.textAlignment = NSTextAlignment.Center
        damageLabel!.font = UIFont(name: "DB LCD Temp", size: UIAdapter.shared.transferHeight(10))
        damageLabel!.textColor = UIColor.whiteColor()
        self.addSubview(damageLabel!)
        
        healLabel = UILabel()
        healLabel?.textAlignment = NSTextAlignment.Center
        healLabel!.font = UIFont(name: "DB LCD Temp", size: UIAdapter.shared.transferHeight(10))
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
