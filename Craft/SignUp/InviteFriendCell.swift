//
//  InviteFriendCell.swift
//  Craft
//
//  Created by castiel on 16/7/11.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class InviteFriendCell: UITableViewCell {

    var dutyView : currentDutyView?
    var backgroundImage : UIImageView?
    var selectedBackgroundImage : UIImageView?
    var icon : UIImageView?
    var name : UILabel?
    var account : UILabel?
    var honor : UIImageView?
    var honorlabel : UILabel?
    
    init(style: UITableViewCellStyle, reuseIdentifier: String? , cellWidth : CGFloat, cellHeight : CGFloat) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: cellWidth, height: cellHeight))
        self.backgroundImage!.image = UIImage(named: "activityItem")
        self.addSubview(self.backgroundImage!)
        
        self.selectedBackgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: cellWidth, height: cellHeight))
        self.selectedBackgroundImage!.image = UIImage(named: "selected_friend")
        self.selectedBackgroundImage!.hidden = true
        self.addSubview(self.selectedBackgroundImage!)
        
        icon = UIImageView(frame: CGRect(x: UIAdapter.shared.transferWidth(5), y: 5, width: 34, height: 34))
        icon!.image  = UIImage(named: "dz")
        self.addSubview(self.icon!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
