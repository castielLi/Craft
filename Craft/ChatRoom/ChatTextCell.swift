//
//  ChatTextCell.swift
//  
//
//  Created by Rex Tsao on 3/2/16.
//
//

import UIKit

class ChatTextCell: ChatCell {
    
    private var messageLabel: UILabel?

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
        self.createLabel()
        self.backgroundColor = UIColor.clearColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createLabel() {
        if self.messageLabel == nil {
            self.messageLabel = UILabel()
            self.messageLabel?.font = UIFont.systemFontOfSize(16)
            self.messageLabel?.numberOfLines = 0

            self.addSubview(self.messageLabel!)
        }
    }
    
    override func setMessage(message: ChatMessage) {
        super.setMessage(message)

        self.messageLabel?.text = (message as! ChatTextMessage).text
        self.messageLabel?.frame = CGRect(origin: self.messageLabel!.frame.origin, size: (message as! ChatTextMessage).messageSize!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Because there is 5 pixels disparity in background image, so here use gapLabelMessage to make up.
        var y = self.imageViewAvatar!.frame.origin.y + self.gapLabelMessage 
        var x = self.imageViewAvatar!.frame.origin.x + (self.message!.ownerType == .Mine ? -self.gapBackground - self.gapBackground - self.gapLabelMessage - self.messageLabel!.frame.width : self.imageViewAvatar!.frame.width + self.gapBackground + self.gapBackground + self.gapLabelMessage)
        self.messageLabel?.frame.origin = CGPointMake(x, y)
        
//        x -= 18
//        y = self.imageViewAvatar!.frame.origin.y - 5    //There is 5 pixels different in background image.
//        let h = max(self.messageLabel!.frame.height + 30, self.imageViewAvatar!.frame.height + 10)
//        self.imageViewMessageBackground?.frame = CGRectMake(x, y, self.messageLabel!.frame.width + 40, h)
        
        x = x - self.gapLabelMessage - self.gapBackground
        y = y - self.gapLabelMessage - self.gapBackground
        let h = self.messageLabel!.frame.height + 2 * self.gapLabelMessage + 2 * self.gapBackground
        let w = self.messageLabel!.frame.width + 2 * self.gapLabelMessage + 2 * self.gapBackground
        self.imageViewMessageBackground?.frame = CGRectMake(x, y, w, h)
    }
}
