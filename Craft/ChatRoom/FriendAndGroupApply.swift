//
//  FriendAndGroupApply.swift
//  Craft
//
//  Created by castiel on 16/8/21.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class FriendAndGroupApply: UITableViewCell {
    
    var backgroundImage : UIImageView?
    var icon : UIImageView?
    var name : UILabel?
    var content : UILabel?
    
    var applyButton : UILabel?

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
        
        content = UILabel()
        content!.textColor = Resources.Color.accountColor
        content!.font = UIFont(name: "KaiTi", size: 9)
        content!.text = "li.qinzhu0205@hotmail.com"
        self.addSubview(content!)
        
        self.content!.mas_makeConstraints{ make in
            make.top.equalTo()(self.name!.mas_bottom).with().offset()(2)
            make.left.equalTo()(self.icon!.mas_right).with().offset()(UIAdapter.shared.transferWidth(2))
            make.height.equalTo()(15)
            make.width.equalTo()(self.frame.width * 0.4)
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
