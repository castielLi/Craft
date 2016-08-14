//
//  InviteFriendCell.swift
//  Craft
//
//  Created by castiel on 16/7/11.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class InviteFriendCell: UITableViewCell {

    var dutyView : currentDutyView?
    var backgroundImage : UIImageView?
    var selectedBackgroundImage : UIImageView?
    var icon : UIImageView?
    var name : UILabel?
    var account : UILabel?
    var honor : UIImageView?
    var honorlabel : UILabel?
    var cellSelected: Bool = false
    
    init(style: UITableViewCellStyle, reuseIdentifier: String? , cellWidth : CGFloat, cellHeight : CGFloat) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: cellWidth, height: cellHeight))
        self.backgroundImage!.image = UIImage(named: "activityItem")
        self.addSubview(self.backgroundImage!)
        
        self.selectedBackgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: cellWidth, height: cellHeight))
        self.selectedBackgroundImage!.image = UIImage(named: "selected_friend")
        self.selectedBackgroundImage!.hidden = true
        self.addSubview(self.selectedBackgroundImage!)
        
        icon = UIImageView(frame: CGRect(x: UIAdapter.shared.transferWidth(5), y: 5, width: 44, height: 44))
        icon!.image  = UIImage(named: "playericon")
        self.addSubview(self.icon!)
        
        
        name = UILabel()
        name!.textColor = UIColor.whiteColor()
        name!.font = UIFont(name: "KaiTi", size: 14)
        name!.text = "伊莎贝拉殿下"
        self.addSubview(name!)
        
        self.name!.mas_makeConstraints{ make in
            make.top.equalTo()(self.icon!).with().offset()(3)
            make.left.equalTo()(self.icon!.mas_right).with().offset()(UIAdapter.shared.transferWidth(2))
            make.height.equalTo()(20)
            make.width.equalTo()(self.frame.width * 0.5)
        }
        
        account = UILabel()
        account!.textColor = Resources.Color.accountColor
        account!.font = UIFont(name: "KaiTi", size: 9)
        account!.text = "li.qinzhu0205@hotmail.com"
        self.addSubview(account!)
        
        self.account!.mas_makeConstraints{ make in
            make.top.equalTo()(self.name!.mas_bottom).with().offset()(2)
            make.left.equalTo()(self.icon!.mas_right).with().offset()(UIAdapter.shared.transferWidth(2))
            make.height.equalTo()(15)
            make.width.equalTo()(self.frame.width * 0.5)
        }
        
        honor = UIImageView(frame : CGRect(x: self.frame.width * 0.5 + 10 + self.icon!.frame.width + self.icon!.frame.origin.x , y: 12, width: 30, height: 30))
        honor!.image = UIImage(named: "honour")
        self.addSubview(honor!)
        
        honorlabel = UILabel()
        honorlabel!.text = "1000"
        honorlabel!.textColor = Resources.Color.dailyColor
        honorlabel!.font = UIFont(name: "DB LCD Temp", size: 12)
        self.addSubview(honorlabel!)
        
        self.honorlabel!.mas_makeConstraints{ make in
            make.bottom.equalTo()(self.honor)
            make.height.equalTo()(15)
            make.width.equalTo()(40)
            make.centerY.equalTo()(self.honor)
            make.left.equalTo()(self.honor!.mas_right).with().offset()(UIAdapter.shared.transferWidth(5))
        }


    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
