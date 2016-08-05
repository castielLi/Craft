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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
