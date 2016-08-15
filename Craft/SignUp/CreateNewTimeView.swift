//
//  CreateNewTimeView.swift
//  Craft
//
//  Created by castiel on 16/7/10.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class CreateNewTimeView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var date : UILabel?
    var time : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        date = UILabel()
        date!.textColor = UIColor.whiteColor()
        date!.font = UIAdapter.shared.transferFont(8)
        self.addSubview(self.date!)
        
        self.date!.mas_makeConstraints{ make in
           make.top.equalTo()(UIAdapter.shared.transferHeight(2))
           make.height.equalTo()(UIAdapter.shared.transferHeight(10))
            make.centerX.equalTo()(self)
        }
        
        
        time = UILabel()
        time!.textColor = UIColor.whiteColor()
        time!.font = UIFont(name: "Papyrus-Regular", size: UIAdapter.shared.transferHeight(20))
        self.addSubview(self.time!)
        
        self.time!.mas_makeConstraints{ make in
           make.top.equalTo()(self.date!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(2))
           make.height.equalTo()(UIAdapter.shared.transferHeight(22))
           make.centerX.equalTo()(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
