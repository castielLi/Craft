//
//  ChatListCell.swift
//  Craft
//
//  Created by castiel on 16/5/29.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class ChatListCell: TableViewBaseCell {

    var backgroundImage : UIImageView?
    
    var icon : UIImageView?
    var name : UILabel?
    var account : UILabel?
    var count : UILabel?
    var message : UILabel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, cellHeight: CGFloat , cellWidth : CGFloat) {
        super.init(style: style, reuseIdentifier: reuseIdentifier, cellHeight: cellHeight)
        
        backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: cellWidth, height: cellHeight))
        backgroundImage!.image = UIImage(named: "activityItem")
        self.addSubview(backgroundImage!)
        
        icon = UIImageView()
        icon!.image = UIImage(named: "dz")
        self.addSubview(icon!)
        
        self.icon!.mas_makeConstraints{ make in
            make.centerY.equalTo()(self)
            make.left.equalTo()(self).with().offset()(UIAdapter.shared.transferWidth(10))
            make.width.equalTo()(UIAdapter.shared.transferWidth(40))
            make.height.equalTo()(UIAdapter.shared.transferWidth(40))
        }
        
        let iconRange = CALayer()
        iconRange.frame = CGRectMake(0, 0, UIAdapter.shared.transferWidth(40), UIAdapter.shared.transferWidth(40))
        iconRange.contents = UIImage(named: "iconWidth")!.CGImage
        self.icon!.layer.addSublayer(iconRange)
        
        count = UILabel()
        count!.textColor = UIColor.whiteColor()
        count!.layer.cornerRadius = 7
        count!.layer.masksToBounds = true
        count!.backgroundColor = UIColor.redColor()
        count!.text = "99"
        count!.font = UIFont.systemFontOfSize(10)
        self.addSubview(count!)
        
        self.count!.mas_makeConstraints{ make in
            make.top.equalTo()(self.icon!).with().offset()(UIAdapter.shared.transferHeight(-2))
            make.height.equalTo()(14)
            make.width.equalTo()(14)
            make.left.equalTo()(self.icon!).with().offset()(UIAdapter.shared.transferWidth(-5))
        }
        
        
        name = UILabel()
        name!.textColor = UIColor.whiteColor()
        name!.text = "夏拉诺瑞"
        name!.font = UIFont.systemFontOfSize(13)
        self.addSubview(name!)
        
        self.name!.mas_makeConstraints{ make in
           make.top.equalTo()(self.icon!)
           make.height.equalTo()(13)
           make.left.equalTo()(self.icon!.mas_right).with().offset()(UIAdapter.shared.transferWidth(5))
           make.right.equalTo()(self).with().offset()(UIAdapter.shared.transferWidth(-10))
        }
        
        account = UILabel()
        account!.textColor = Resources.Color.accountColor
        account!.text = "sanctimony@126.com"
        account!.font = UIFont.systemFontOfSize(10)
        self.addSubview(account!)
        
        self.account!.mas_makeConstraints{ make in
            make.top.equalTo()(self.name!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(2))
            make.height.equalTo()(10)
            make.left.equalTo()(self.icon!.mas_right).with().offset()(UIAdapter.shared.transferWidth(5))
            make.right.equalTo()(self).with().offset()(UIAdapter.shared.transferWidth(-10))
        }
        
        message = UILabel()
        message!.textColor = UIColor.lightGrayColor()
        message!.text = "今天晚上地狱火堡垒7-12h，7点半开始组，早点到去组人。自备合计药水！！"
        message!.font = UIFont.systemFontOfSize(12)
        self.addSubview(message!)
        
        self.message!.mas_makeConstraints{ make in
            make.top.equalTo()(self.account!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(5))
            make.height.equalTo()(12)
            make.left.equalTo()(self.icon!.mas_right).with().offset()(UIAdapter.shared.transferWidth(5))
            make.right.equalTo()(self).with().offset()(UIAdapter.shared.transferWidth(-10))
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
