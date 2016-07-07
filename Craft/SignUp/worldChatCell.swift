//
//  worldChatCell.swift
//  Craft
//
//  Created by castiel on 16/7/7.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class worldChatCell: UITableViewCell {
    
    var content : UILabel?
    var userId : String?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String? , cellWidth : CGFloat) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clearColor()
        
        content = UILabel(frame:CGRect(x: UIAdapter.shared.transferWidth(3), y: UIAdapter.shared.transferHeight(2), width: cellWidth - UIAdapter.shared.transferWidth(6), height: self.frame.height - UIAdapter.shared.transferHeight(4)))
        content!.font = UIAdapter.shared.transferFont(10)
        content!.textColor = Resources.Color.dailyColor
        content!.textAlignment = NSTextAlignment.Left
        content!.numberOfLines = 0
        self.addSubview(self.content!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
