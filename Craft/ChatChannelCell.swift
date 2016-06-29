//
//  ChatChannelCell.swift
//  Craft
//
//  Created by Rex Tsao on 28/6/2016.
//  Copyright © 2016 castiel. All rights reserved.
//

import UIKit

class ChatChannelCell: TableViewBaseCell {

    var labelTitle: UILabel?
    var labelNumberOfPlayers: UILabel?
    var imageViewBackground: UIImageView?
    var backgroundImage : UIImageView?
    private var labelNumInChannel: UILabel?
    
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, cellHeight: CGFloat, cellWidth: CGFloat) {
        super.init(style: style, reuseIdentifier: reuseIdentifier, cellHeight: cellHeight)
        self.backgroundColor = nil
        
        backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: cellHeight))
        backgroundImage!.image = UIImage(named: "activityItem")
        self.addSubview(backgroundImage!)
        
        self.attachMain()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func attachMain() {
        let bgHeight = uiah(50)
        let bgWidth = bgHeight / UIImage(named: "channel_alliance")!.size.height * UIImage(named: "channel_alliance")!.size.width
        
        print("width and height: \(bgWidth), \(bgHeight)")
        self.imageViewBackground = UIImageView(image: UIImage(named: ""))
        self.imageViewBackground?.frame = CGRect(origin: CGPointZero, size: CGSizeMake(bgWidth, bgHeight))
        self.addSubview(self.imageViewBackground!)
        
        self.labelTitle = UILabel()
        self.labelTitle?.textColor = Resources.Color.dailyColor
//        self.labelTitle?.sizeToFit()
        self.labelTitle!.font = UIAdapter.shared.transferFont(10)
        self.addSubview(self.labelTitle!)
        self.labelTitle!.mas_makeConstraints{ make in
           make.height.equalTo()(UIAdapter.shared.transferHeight(10))
           make.left.equalTo()(self).with().offset()(UIAdapter.shared.transferWidth(10))
           make.centerY.equalTo()(self)
        }
        
//        self.labelNumInChannel = UILabel()
//        self.labelNumInChannel?.text = "频道人数："
//        self.labelNumInChannel?.font = UIFont.systemFontOfSize(uiat(12))
//        self.labelNumInChannel?.textColor = UIColor.whiteColor()
//        self.labelNumInChannel?.sizeToFit()
//        self.addSubview(labelNumInChannel!)
//        
//        self.labelNumberOfPlayers = UILabel()
//        self.labelNumberOfPlayers?.text = String(2864)
//        self.labelNumberOfPlayers?.font = UIFont.systemFontOfSize(uiat(12))
//        self.labelNumberOfPlayers?.textColor = UIColor.whiteColor()
//        self.labelNumberOfPlayers?.sizeToFit()
//        self.addSubview(self.labelNumberOfPlayers!)
    }

    func setMessage(title: String, numberInThisChannel: String, backgroundImage: UIImage) {
        self.labelTitle?.text = title
//        self.labelTitle?.sizeToFit()
        
//        self.labelNumberOfPlayers?.text = numberInThisChannel
//        self.labelNumberOfPlayers?.sizeToFit()
//        
        self.imageViewBackground?.image = backgroundImage
    }
    
    override func layoutSubviews() {
//        var startX = uiat(10)
//        var startY = uiah(10)
//        
//        self.labelTitle?.frame.origin = CGPointMake(startX, startY)
        
//        startX = (self.frame.width - self.labelNumInChannel!.frame.width) / 2
//        startY = self.frame.height - startY - self.labelNumInChannel!.frame.height
//        
//        self.labelNumInChannel?.frame.origin = CGPointMake(startX, startY)
//        self.labelNumberOfPlayers?.frame.origin = CGPointMake(startX + self.labelNumInChannel!.frame.width, startY)
        
        self.imageViewBackground?.frame.origin = CGPointMake(self.frame.width - self.imageViewBackground!.frame.width, 0)
    }
}
