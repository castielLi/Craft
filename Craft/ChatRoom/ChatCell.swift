//
//  ChatCell.swift
//  
//
//  Created by Rex Tsao on 3/2/16.
//
//

import UIKit

class ChatCell: UITableViewCell {
    
    var imageViewAvatar: UIImageView?
    var imageViewMessageBackground: UIImageView?
    var message: ChatMessage?
    var username : UILabel?
    
    /// This defined the gap that from portrait to its nearest bound, its super view's bound.
    let gapPortrait: CGFloat = 10
    /// This defined the gap that from background image view to its nearest portrait bound.
    let gapBackground: CGFloat = 5
    /// This defined the gap that from message label to its super view.
    let gapLabelMessage: CGFloat = 10
    /// This defined the gap that from message label to its super view at horizontal dimension.
//    let gapLabelMessageHorizontal: CGFloat = 15
    

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
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        self.createAvatar()
        self.createMessageBackground()
        self.createNameLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func createAvatar() {
        if self.imageViewAvatar == nil {
            let avatarSize: CGFloat = 40
            self.imageViewAvatar = UIImageView(frame: CGRectMake(0, 0, avatarSize, avatarSize))
            self.imageViewAvatar?.layer.cornerRadius = avatarSize / 2
            self.imageViewAvatar?.layer.masksToBounds = true
            self.addSubview(self.imageViewAvatar!)
        }
    }
    
    private func createMessageBackground() {
        if self.imageViewMessageBackground == nil {
            self.imageViewMessageBackground = UIImageView()
            self.addSubview(self.imageViewMessageBackground!)
        }
    }
    
    private func createNameLabel() {
        if self.username == nil {
            self.username = UILabel(frame : CGRect(x: 0, y: 0, width: 70, height: 12))
            self.username!.textColor = UIColor.whiteColor()
            self.username!.font = UIFont(name: "KaiTi", size: 10)
            self.username!.hidden = true
            self.addSubview(self.username!)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.message!.ownerType == .Mine {
            self.imageViewAvatar?.frame.origin = CGPointMake(self.frame.width - self.gapPortrait - self.imageViewAvatar!.frame.width, self.gapPortrait)
        } else {
            self.imageViewAvatar?.frame.origin = CGPointMake(self.gapPortrait, self.gapPortrait)
        }
        
        if self.message!.showName{
            self.username!.hidden = false
            if self.message!.ownerType == .Mine {
                self.username!.frame.origin = CGPointMake(self.frame.width - self.gapPortrait - self.imageViewAvatar!.frame.width - 10 - 70, self.gapPortrait)
                self.username!.textAlignment = NSTextAlignment.Right
            } else {
                self.username!.frame.origin = CGPointMake(self.imageViewAvatar!.frame.origin.x + self.imageViewAvatar!.frame.width + 10  , self.imageViewAvatar!.frame.origin.y)
                self.username!.textAlignment = NSTextAlignment.Left
            }
            
        }else{
           self.username!.hidden = true
        }
    }
    
    func setMessage(message: ChatMessage) {
        self.message = message
        self.imageViewAvatar?.image = message.portrait
        switch message.ownerType {
        case .Mine:
            self.imageViewMessageBackground?.image = UIImage(named: "message_sender_background_normal")?.resizableImageWithCapInsets(UIEdgeInsetsMake(28, self.message!.showName ?35:20, 15, 20), resizingMode: .Stretch)
            self.imageViewMessageBackground?.highlightedImage = UIImage(named: "message_sender_background_highlight")?.resizableImageWithCapInsets(UIEdgeInsetsMake(28, self.message!.showName ?35:20, 15, 20), resizingMode: .Stretch)
        case .Other:
            self.imageViewMessageBackground?.image = UIImage(named: "message_receiver_background_normal")?.resizableImageWithCapInsets(UIEdgeInsetsMake(28, self.message!.showName ?35:20, 15, 20), resizingMode: .Stretch)
            self.imageViewMessageBackground?.highlightedImage = UIImage(named: "message_receiver_background_highlight")?.resizableImageWithCapInsets(UIEdgeInsetsMake(28, self.message!.showName ?35:20, 15, 20), resizingMode: .Stretch)
        }
        if self.message!.showName{
        self.username?.text = message.username!
        }
    }
}
