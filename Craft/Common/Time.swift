//
//  Time.swift
//  Craft
//
//  Created by castiel on 16/5/7.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class Time: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var firstPart: UILabel?
    var secondPart : UILabel?
    var midPart : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        firstPart = UILabel()
        firstPart!.font = UIFont(name: "DB LCD Temp", size: UIAdapter.shared.transferHeight(20))
        firstPart!.textColor = UIColor.whiteColor()
        self.addSubview(firstPart!)
        
        firstPart!.mas_makeConstraints{make in
           make.top.equalTo()(self)
           make.left.equalTo()(self)
           make.bottom.equalTo()(self)
        }
        
        midPart = UILabel()
        midPart!.font = UIFont(name: "DB LCD Temp", size: UIAdapter.shared.transferHeight(20))
        midPart!.textColor = UIColor.whiteColor()
        self.addSubview(midPart!)
        
        midPart!.mas_makeConstraints{make in
            make.top.equalTo()(self)
            make.left.equalTo()(self.firstPart!.mas_right)
            make.bottom.equalTo()(self)
        }
        
        secondPart = UILabel()
        secondPart!.font = UIFont(name: "DB LCD Temp", size: UIAdapter.shared.transferHeight(20))
        secondPart!.textColor = UIColor.whiteColor()
        self.addSubview(secondPart!)
        
        secondPart!.mas_makeConstraints{make in
            make.top.equalTo()(self)
            make.left.equalTo()(self.midPart!.mas_right)
            make.bottom.equalTo()(self)
        }


    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
