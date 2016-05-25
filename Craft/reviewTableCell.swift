//
//  reviewTableCell.swift
//  Craft
//
//  Created by castiel on 16/3/15.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class reviewTableCell: TableViewBaseCell {
    
    var iconImage : UIImageView?
    var name : UILabel?
    var honourImage : UIImageView?
    var account : UILabel?
    var divideLabel : UILabel?
    var timeLabel : UILabel?
    var content : UILabel?
    var honourCount : UILabel?
    var dutyView : DutyDisplayView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?, cellHeight: CGFloat , lineColor : UIColor) {
        super.init(style: style, reuseIdentifier: reuseIdentifier, cellHeight: cellHeight , lineColor: lineColor)
        
        iconImage = UIImageView(frame: CGRect(x: UIAdapter.shared.transferWidth(10), y: UIAdapter.shared.transferHeight(5), width: UIAdapter.shared.transferWidth(50), height: UIAdapter.shared.transferWidth(50)))
        
        
       
        iconImage!.image = UIImage(named: "icon")
        iconImage!.layer.cornerRadius = UIAdapter.shared.transferWidth(25)
        iconImage!.layer.masksToBounds = true
        self.addSubview(iconImage!)
        
        let iconRange = CALayer()
        iconRange.frame = CGRectMake(0, 0, UIAdapter.shared.transferWidth(50), UIAdapter.shared.transferWidth(50))
        iconRange.contents = UIImage(named: "iconWidth")!.CGImage
        self.iconImage!.layer.addSublayer(iconRange)
        
        name = UILabel()
        name!.text = "伊莎贝拉殿下"
        name!.textColor = UIColor.whiteColor()
        self.name!.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: UIAdapter.shared.transferHeight(13))
        self.addSubview(name!)
        
        name!.mas_makeConstraints{ make in
           make.top.equalTo()(self.iconImage!).with().offset()(UIAdapter.shared.transferWidth(10))
           make.left.equalTo()(self.iconImage!.mas_right).with().offset()(UIAdapter.shared.transferWidth(15))
        }
        
        account = UILabel()
        account!.text = "sanctimony@126.com"
        account!.textColor = Resources.Color.accountColor
        self.account!.font = UIFont.systemFontOfSize(UIAdapter.shared.transferHeight(10))
        self.addSubview(account!)
        
        account!.mas_makeConstraints{ make in
            make.top.equalTo()(self.name!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(2))
            make.left.equalTo()(self.iconImage!.mas_right).with().offset()(UIAdapter.shared.transferWidth(15))
        }
        
        self.divideLabel = UILabel()
        self.divideLabel!.layer.borderColor = Resources.Color.dailyColor.CGColor
        self.divideLabel!.layer.borderWidth = 1
        self.addSubview(self.divideLabel!)
        self.divideLabel!.mas_makeConstraints{ make in
           make.top.equalTo()(self.iconImage!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(2))
           make.left.equalTo()(self)
           make.right.equalTo()(self)
           make.height.equalTo()(1)
        }
        
        honourImage = UIImageView()
        honourImage!.image = UIImage(named: "honour")
        self.addSubview(honourImage!)
        
        honourImage!.mas_makeConstraints{ make in
            make.top.equalTo()(self.divideLabel!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(5))
            make.left.equalTo()(self.iconImage!)
            make.right.equalTo()(self.iconImage!.mas_left).with().offset()(UIAdapter.shared.transferWidth(25))
            make.height.equalTo()(UIAdapter.shared.transferWidth(25))
        }
        
        honourCount = UILabel()
        honourCount!.text = "168"
        honourCount!.textColor = Resources.Color.dailyColor
        self.honourCount!.font = UIFont.systemFontOfSize(UIAdapter.shared.transferHeight(10))
        self.addSubview(honourCount!)
        
        honourCount!.mas_makeConstraints{ make in
            make.top.equalTo()(self.honourImage!.mas_top).with().offset()(UIAdapter.shared.transferWidth(5))
            make.bottom.equalTo()(self.honourImage!).with().offset()(-UIAdapter.shared.transferWidth(5))
            make.left.equalTo()(self.honourImage!.mas_right).with().offset()(UIAdapter.shared.transferWidth(5))
        }
        
        content = UILabel()
        content!.text = "小贼是我,颜色不一样的烟火"
        content!.textColor = UIColor.lightGrayColor()
        self.content!.font = UIFont.systemFontOfSize(UIAdapter.shared.transferHeight(10))
        self.addSubview(content!)
        
        content!.mas_makeConstraints{ make in
            make.top.equalTo()(self.honourImage!.mas_top).with().offset()(UIAdapter.shared.transferWidth(5))
            make.bottom.equalTo()(self.honourImage!).with().offset()(-UIAdapter.shared.transferWidth(5))
            make.left.equalTo()(self.honourCount!.mas_right).with().offset()(UIAdapter.shared.transferWidth(15))
        }

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
