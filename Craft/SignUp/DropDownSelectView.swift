//
//  DropDownSelectView.swift
//  Craft
//
//  Created by castiel on 16/7/10.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class DropDownSelectView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var typeName : String?
    var backgroundImage : UIImageView?
    var displayLabel : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        backgroundImage!.image = UIImage(named: "dropdownSelect")
        self.addSubview(backgroundImage!)
        
        self.displayLabel = UILabel()
        self.displayLabel!.font = UIFont(name: "KaiTi", size: UIAdapter.shared.transferHeight(9) )
        self.displayLabel!.textColor = Resources.Color.dailyColor
        self.addSubview(displayLabel!)
        
        self.displayLabel!.mas_makeConstraints{ make in
           make.width.equalTo()(self.frame.width * 0.85)
           make.left.equalTo()(self).with().offset()(3)
           make.top.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(2))
           make.bottom.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(-2))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
