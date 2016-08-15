//
//  playerListCell.swift
//  Craft
//
//  Created by castiel on 16/8/3.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class playerListCell: UITableViewCell {

    var icon : UIImageView?
    var name : UILabel?
    var account : UILabel?
    var responseIcon : UIImageView?
    var jobIcon : UIButton?
    var dutyIcon : UIButton?
    var backgroundImage : UIImageView?
    var footer : PlayerFooter?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String? , height : CGFloat , width: CGFloat) {
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
           make.width.equalTo()(self.frame.width * 0.4)
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
        
        responseIcon = UIImageView()
        responseIcon!.image = UIImage(named: "leader")
        self.addSubview(responseIcon!)
        
        self.responseIcon!.mas_makeConstraints{ make in
           make.top.equalTo()(self).with().offset()(15)
           make.height.equalTo()(20)
           make.width.equalTo()(15)
           make.left.equalTo()(self.account!.mas_right).with().offset()(UIAdapter.shared.transferWidth(3))
        }
        
        jobIcon = UIButton()
        jobIcon!.setBackgroundImage(UIImage(named: "qs"), forState: UIControlState.Normal)
        self.addSubview(jobIcon!)
        
        self.jobIcon!.mas_makeConstraints{ make in
            make.top.equalTo()(self).with().offset()(12)
            make.height.equalTo()(26)
            make.width.equalTo()(26)
            make.left.equalTo()(self.responseIcon!.mas_right).with().offset()(UIAdapter.shared.transferWidth(12))
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

        footer = PlayerFooter(frame: CGRect(x: 0, y: 50, width: width, height: 30))
        footer!.hidden = true
        self.addSubview(footer!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
