//
//  ActivityItemCell.swift
//  Craft
//
//  Created by castiel on 16/5/7.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class ActivityItemCell: TableViewBaseCell{

    var backgroundImage : UIImageView?
    
    var iconImage : UIImageView?
    var raidName : UILabel?
    
    var dutyPart : dutyView?
    var contentLabel: UILabel?
    var timePart : Time?
    var leadName : UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, cellHeight: CGFloat , cellWidth : CGFloat){
        super.init(style: style, reuseIdentifier: reuseIdentifier, cellHeight: cellHeight , lineColor: UIColor.blackColor())
        
        self.backgroundColor = UIColor.blackColor()
        
        backgroundImage = UIImageView(frame: CGRect(x: 0, y: 2, width: cellWidth, height: cellHeight - 2))
        self.addSubview(backgroundImage!)
        
        iconImage =  UIImageView(frame: CGRect(x: UIAdapter.shared.transferWidth(5) , y: UIAdapter.shared.transferHeight(5), width: UIAdapter.shared.transferWidth(40) , height: cellHeight - UIAdapter.shared.transferHeight(20)))
        self.addSubview(iconImage!)
        
        self.raidName = UILabel()
        self.raidName!.textColor = UIColor.whiteColor()
        self.addSubview(raidName!)
        self.raidName?.mas_makeConstraints{ make in
          make.left.equalTo()(self.iconImage!.mas_right).with().offset()(UIAdapter.shared.transferWidth(6))
          make.top.equalTo()(self.iconImage!).with().offset()(UIAdapter.shared.transferHeight(3))
        }
        
        dutyPart = dutyView(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferWidth(90), height: UIAdapter.shared.transferHeight(23)))
        self.addSubview(dutyPart!)
        
        self.dutyPart!.mas_makeConstraints{ make in
           make.top.equalTo()(self.raidName!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(3))
           make.left.equalTo()(self.raidName)
           make.right.equalTo()(self.raidName!.mas_left).with().offset()(UIAdapter.shared.transferWidth(90))
           make.bottom.equalTo()(self.raidName!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(26))
        }
        
        
        contentLabel = UILabel()
        contentLabel!.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: UIAdapter.shared.transferHeight(8))
        contentLabel!.textColor = UIColor.whiteColor()
        self.addSubview(contentLabel!)
        
        self.contentLabel!.mas_makeConstraints{ make in
           make.left.equalTo()(self).with().offset()(UIAdapter.shared.transferWidth(5))
           make.right.equalTo()(self.dutyPart!)
           make.top.equalTo()(self.dutyPart!.mas_bottom).with().offset()(2)
           make.bottom.equalTo()(self).with().offset()(-3)
        }
        
        
        timePart = Time(frame: CGRect(x: 0, y: 0, width: UIAdapter.shared.transferHeight(60), height: UIAdapter.shared.transferHeight(20)))
       
        self.addSubview(timePart!)
        
        self.timePart!.mas_makeConstraints{make in
           make.centerY.equalTo()(self)
           make.right.equalTo()(self).with().offset()(UIAdapter.shared.transferWidth(-20))
           make.left.equalTo()(self.mas_right).with().offset()(-UIAdapter.shared.transferWidth(80))
           make.height.equalTo()(UIAdapter.shared.transferHeight(20))
        }
        
        leadName = UILabel()
        leadName!.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: UIAdapter.shared.transferHeight(8))
        leadName!.textColor = UIColor.whiteColor()
        self.addSubview(leadName!)
        
        self.leadName!.mas_makeConstraints{make in
           make.top.equalTo()(self.contentLabel!)
           make.bottom.equalTo()(self.contentLabel!)
           make.centerX.equalTo()(self.timePart!)
           make.height.equalTo()(UIAdapter.shared.transferHeight(10))
        }
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
