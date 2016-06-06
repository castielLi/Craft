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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.message!.ownerType == .Mine {
            self.imageViewAvatar?.frame.origin = CGPointMake(self.frame.width - self.gapPortrait - self.imageViewAvatar!.frame.width, self.gapPortrait)
        } else {
            self.imageViewAvatar?.frame.origin = CGPointMake(self.gapPortrait, self.gapPortrait)
        }
    }
    
    func setMessage(message: ChatMessage) {
        self.message = message
        self.imageViewAvatar?.image = message.portrait
        switch message.ownerType {
        case .Mine:
            self.imageViewMessageBackground?.image = UIImage(named: "message_sender_background_normal")?.resizableImageWithCapInsets(UIEdgeInsetsMake(28, 20, 15, 20), resizingMode: .Stretch)
            self.imageViewMessageBackground?.highlightedImage = UIImage(named: "message_sender_background_highlight")?.resizableImageWithCapInsets(UIEdgeInsetsMake(28, 20, 15, 20), resizingMode: .Stretch)
        case .Other:
            self.imageViewMessageBackground?.image = UIImage(named: "message_receiver_background_normal")?.resizableImageWithCapInsets(UIEdgeInsetsMake(28, 20, 15, 20), resizingMode: .Stretch)
            self.imageViewMessageBackground?.highlightedImage = UIImage(named: "message_receiver_background_highlight")?.resizableImageWithCapInsets(UIEdgeInsetsMake(28, 20, 15, 20), resizingMode: .Stretch)
        }
    }
}
