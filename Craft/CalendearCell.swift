//
//  CalendearCell.swift
//  Craft
//
//  Created by castiel on 16/1/26.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class CalendearCell: UICollectionViewCell {
    
    var contentLabel : UILabel?
    var iconImage : UIImageView?
    var normalLabel : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = UIAdapter.shared.transferWidth(2)
        self.layer.borderWidth = 1
        self.layer.borderColor = Resources.Color.goldenEdge.CGColor
        self.layer.masksToBounds = true

        
        normalLabel = UILabel()
        normalLabel!.frame = self.bounds
        normalLabel!.textAlignment = .Center
        normalLabel!.backgroundColor = UIColor.clearColor()
        normalLabel!.textColor = UIColor.whiteColor()
        self.addSubview(normalLabel!)

        
        contentLabel = UILabel()
        contentLabel!.textAlignment = .Center
        contentLabel!.hidden = true
        contentLabel!.backgroundColor = UIColor.clearColor()
        contentLabel!.textColor = UIColor.whiteColor()
        self.addSubview(contentLabel!)
        contentLabel!.mas_makeConstraints{ make in
          make.top.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(2))
          make.bottom.equalTo()(self.mas_top).with().offset()(UIAdapter.shared.transferHeight(15))
          make.right.equalTo()(self)
          make.left.equalTo()(self)
        }
        
        iconImage = UIImageView()
        iconImage!.hidden = true
        iconImage!.image = UIImage(named: "icon")
        self.addSubview(iconImage!)
        
        iconImage!.mas_makeConstraints{ make in
            make.top.equalTo()(self.contentLabel!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(2))
            make.bottom.equalTo()(self).with().offset()(UIAdapter.shared.transferHeight(-2))
            make.right.equalTo()(self).with().offset()(UIAdapter.shared.transferWidth(-10))
            make.left.equalTo()(self).with().offset()(UIAdapter.shared.transferWidth(10))
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
