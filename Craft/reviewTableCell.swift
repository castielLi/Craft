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
    var activitiesName : UILabel?
    var divideLabel : UILabel?
    var timeLabel : UILabel?
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
        
        
        activitiesName = UILabel()
        activitiesName!.text = "伊莎贝拉殿下"
        self.activitiesName!.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: UIAdapter.shared.transferHeight(12))
        self.addSubview(activitiesName!)
        
        activitiesName!.mas_makeConstraints{ make in
           make.top.equalTo()(self.iconImage!).with().offset()(UIAdapter.shared.transferHeight(3))
           make.left.equalTo()(self.iconImage!.mas_right).with().offset()(UIAdapter.shared.transferWidth(5))
        }
        
        self.divideLabel = UILabel()
        self.divideLabel!.layer.borderColor = Resources.Color.goldenEdge.CGColor
        self.divideLabel!.layer.borderWidth = 1
        self.addSubview(self.divideLabel!)
        self.divideLabel!.mas_makeConstraints{ make in
           make.centerY.equalTo()(self.iconImage!)
           make.left.equalTo()(self.iconImage!.mas_right).with().offset()(UIAdapter.shared.transferWidth(2))
           make.right.equalTo()(self)
           make.height.equalTo()(1)
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
