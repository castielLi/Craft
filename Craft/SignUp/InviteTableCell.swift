//
//  InviteTableCell.swift
//  Craft
//
//  Created by castiel on 16/7/10.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class InviteTableCell: UITableViewCell {

    var backgroundImage : UIImageView?
    var icon : UIImageView?
    var assistant : UIButton?
    var deleteButton : UIButton?
    var duty : UIImageView?
    var name : UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    init(style: UITableViewCellStyle, reuseIdentifier: String? , cellWidth: CGFloat , cellHeight : CGFloat) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: cellWidth, height: cellHeight))
        self.backgroundImage!.image = UIImage(named: "activityItem")
        self.addSubview(self.backgroundImage!)
        
        icon = UIImageView(frame: CGRect(x: UIAdapter.shared.transferWidth(5), y: 5, width: 34, height: 34))
        icon!.image  = UIImage(named: "dz")
        self.addSubview(self.icon!)
        
        
        self.assistant = UIButton(frame: CGRect(x: cellWidth - 10 - 30, y: 7, width: 30, height: 30))
        self.assistant!.setBackgroundImage(UIImage(named: "assistant"), forState: UIControlState.Normal)
        self.addSubview(self.assistant!)
        
        self.deleteButton = UIButton(frame: CGRect(x: cellWidth - 10 - 65, y: 7, width: 30, height: 30))
        self.deleteButton!.setBackgroundImage(UIImage(named: "delete"), forState: UIControlState.Normal)
        self.addSubview(self.deleteButton!)
        
        self.duty = UIImageView(frame: CGRect(x: cellWidth - 10 - 100, y: 7, width: 30, height: 30))
        self.duty!.image = UIImage(named: "damage")
        self.addSubview(self.duty!)
        
        self.name = UILabel()
        self.name!.text = "灭掉你的欲望"
        self.name?.textColor = Resources.Color.dailyColor
        self.name?.textAlignment = NSTextAlignment.Left
        self.name!.font = UIAdapter.shared.transferFont(11)
        self.addSubview(self.name!)
        
        self.name!.mas_makeConstraints{ make in
           make.centerY.equalTo()(self)
           make.left.equalTo()(self.icon!.mas_right).with().offset()(5)
           make.right.equalTo()(self.duty!.mas_left).with().offset()(-5)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
