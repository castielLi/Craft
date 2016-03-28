//
//  ActivityTableCell.swift
//  Craft
//
//  Created by castiel on 16/3/13.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class ActivityTableCell: TableViewBaseCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?, cellHeight: CGFloat) {
        super.init(style: style, reuseIdentifier: reuseIdentifier, cellHeight: cellHeight)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
