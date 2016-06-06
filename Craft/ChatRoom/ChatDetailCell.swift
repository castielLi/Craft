//
//  ChatDetailCell.swift
//  Craft
//
//  Created by castiel on 16/6/4.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class ChatDetailCell: UITableViewCell {

    var content : UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        content = UILabel()
        content?.mas_makeConstraints{ make in
           make.top.equalTo()(self).with().offset()(5)
           make.bottom.equalTo()(self).with().offset()(-5)
            make.left.equalTo()(self).with().offset()(10)
            make.right.equalTo()(self).with().offset()(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
