//
//  applyListCell.swift
//  Craft
//
//  Created by castiel on 16/8/6.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class applyListCell: UITableViewCell {

    var icon : UIImageView?
    var name : UILabel?
    var account : UILabel?
    var jobIcon : UIButton?
    var dutyIcon : UIButton?
    var backgroundImage : UIImageView?
    var content : UILabel?
    var footer : ApplyFooter?
    var honor : UIImageView?
    var honorNum : UILabel?

    init(style: UITableViewCellStyle, reuseIdentifier: String? , height : CGFloat , width : CGFloat) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: height))
        backgroundImage!.image = UIImage(named: "player_cell")
        self.addSubview(backgroundImage!)
        
        icon = UIImageView(frame: CGRect(x: 5, y: 5, width: 40, height: 40))
        icon!.image = UIImage(named: "playericon")
        self.addSubview(icon!)
        
        name = UILabel()
        name!.textColor = UIColor.whiteColor()
        name!.font = UIFont(name: "KaiTi", size: 14)
        name!.text = "伊莎贝拉殿下"
        self.addSubview(name!)
        
        self.name!.mas_makeConstraints{ make in
            make.top.equalTo()(self.icon!).with().offset()(3)
            make.left.equalTo()(self.icon!.mas_right).with().offset()(UIAdapter.shared.transferWidth(2))
            make.height.equalTo()(20)
            make.width.equalTo()(self.frame.width * 0.3)
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
            make.width.equalTo()(self.frame.width * 0.4)
        }
        
        honor = UIImageView()
        honor!.image = UIImage(named: "honour")
        self.addSubview(honor!)
        self.honor!.mas_makeConstraints{ make in
            make.top.equalTo()(self).with().offset()(12)
            make.height.equalTo()(15)
            make.width.equalTo()(15)
            make.left.equalTo()(self.name!.mas_right).with().offset()(UIAdapter.shared.transferWidth(3))
        }
        
        honorNum = UILabel()
        honorNum!.text = "1000"
        honorNum!.textColor = Resources.Color.dailyColor
        honorNum!.font = UIFont(name: "DB LCD Temp", size: 9)
        self.addSubview(honorNum!)
        
        self.honorNum!.mas_makeConstraints{ make in
            make.bottom.equalTo()(self.honor)
            make.height.equalTo()(15)
            make.width.equalTo()(22)
            make.left.equalTo()(self.honor!.mas_right).with().offset()(UIAdapter.shared.transferWidth(5))
        }
        
        jobIcon = UIButton()
        jobIcon!.setBackgroundImage(UIImage(named: "qs"), forState: UIControlState.Normal)
        self.addSubview(jobIcon!)
        
        self.jobIcon!.mas_makeConstraints{ make in
            make.top.equalTo()(self).with().offset()(12)
            make.height.equalTo()(26)
            make.width.equalTo()(26)
            make.left.equalTo()(self.account!.mas_right).with().offset()(UIAdapter.shared.transferWidth(30))
        }
        
        dutyIcon = UIButton()
        dutyIcon!.setBackgroundImage(UIImage(named: "heal"), forState: UIControlState.Normal)
        self.addSubview(dutyIcon!)
        
        self.dutyIcon!.mas_makeConstraints{ make in
            make.top.equalTo()(self).with().offset()(12)
            make.height.equalTo()(26)
            make.width.equalTo()(26)
            make.left.equalTo()(self.jobIcon!.mas_right).with().offset()(UIAdapter.shared.transferWidth(8))
        }
        
        content = UILabel()
        self.content!.text = "我是老司机,手法犀利,走位风骚"
        self.content!.textColor = UIColor.whiteColor()
        self.content!.font = UIFont(name: "KaiTi", size: 12)
        self.addSubview(content!)
        
        self.content!.mas_makeConstraints{ make in
           make.top.equalTo()(self.account!.mas_bottom).with().offset()(UIAdapter.shared.transferWidth(2))
           make.bottom.equalTo()(self.account!.mas_bottom).with().offset()(12)
           make.left.equalTo()(self).with().offset()(5)
        }
        
        footer = ApplyFooter(frame: CGRect(x: 0, y: 60, width: width, height: 30))
        footer!.hidden = true
        self.addSubview(footer!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
