//
//  currentUserInformation.swift
//  Craft
//
//  Created by castiel on 16/8/13.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class currentUserInformation: UIView {
    
    var titleLabel : UILabel?
    var duty : UIImageView?
    var job : UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel = UILabel()
        titleLabel!.font = UIFont(name: "KaiTi", size: 15)
        titleLabel!.textColor = Resources.Color.dailyColor
        titleLabel!.text = "团长职责确认"
        self.addSubview(titleLabel!)
        
        titleLabel!.mas_makeConstraints{ make in
          make.left.equalTo()(self).with().offset()(10)
          make.centerY.equalTo()(self)
        }
        
        duty = UIImageView()
        duty!.image = UIImage(named: "heal")
        self.addSubview(duty!)
        
        duty!.mas_makeConstraints{ make in
           make.centerY.equalTo()(self)
           make.height.equalTo()(UIAdapter.shared.transferHeight(25))
           make.width.equalTo()(UIAdapter.shared.transferHeight(25))
           make.left.equalTo()(self.titleLabel!.mas_right).with().offset()(UIAdapter.shared.transferWidth(20))
        }
        
        job = UIImageView()
        job!.image = UIImage(named: "fs")
        self.addSubview(job!)
        
        job!.mas_makeConstraints{ make in
            make.centerY.equalTo()(self)
            make.height.equalTo()(UIAdapter.shared.transferHeight(25))
            make.width.equalTo()(UIAdapter.shared.transferHeight(25))
            make.left.equalTo()(self.duty!.mas_right).with().offset()(UIAdapter.shared.transferWidth(20))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
