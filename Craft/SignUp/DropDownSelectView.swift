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
        
        
        self.backgroundColor = UIColor.blackColor()
        backgroundImage = UIImageView(frame: CGRect(x: self.frame.width - 20, y: 0, width: 20, height: frame.height))
        backgroundImage!.image = UIImage(named: "dropdownSelect")
        self.addSubview(backgroundImage!)
        
        self.displayLabel = UILabel()
        self.displayLabel!.text = "请选择"
        self.displayLabel!.font = UIFont(name: "KaiTi", size: UIAdapter.shared.transferHeight(9) )
        self.displayLabel!.textColor = Resources.Color.dailyColor
        self.displayLabel!.textAlignment = NSTextAlignment.Center
        self.addSubview(displayLabel!)
        
        self.displayLabel!.mas_makeConstraints{ make in
           make.width.equalTo()(self.frame.width - 20)
           make.left.equalTo()(self).with().offset()(3)
           make.top.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(2))
           make.bottom.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(-2))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
