//
//  ChatVoiceCell.swift
//  RCToolsDemo
//
//  Created by Rex Tsao on 3/2/16.
//  Copyright (c) 2016 rexcao. All rights reserved.
//

import Foundation

class ChatVoiceCell: ChatCell {
    /// Store a wave image.
    private var messageModel : ChatMessage?
    
    var imageViewWave: UIImageView?
    let newHeight: CGFloat = 60
    /// The closure which will be executed when playing voice.
    var closureVoice: (() -> Void)?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createSoundWave()
        self.backgroundColor = UIColor.clearColor()
        
        // tap to play voice.
        self.imageViewMessageBackground?.userInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ChatVoiceCell.tapToPlay(_:)))
        self.imageViewMessageBackground?.addGestureRecognizer(tapGesture)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func createSoundWave() {
        if self.imageViewWave == nil {
            self.imageViewWave = UIImageView()
            self.addSubview(self.imageViewWave!)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        var y : CGFloat = 0
        if !self.messageModel!.showName{
            y = self.imageViewAvatar!.frame.origin.y + self.gapLabelMessage
        }else{
            y = self.imageViewAvatar!.frame.origin.y + 25
        }
        

        var x = self.imageViewAvatar!.frame.origin.x + (self.message!.ownerType == .Mine ? -self.gapBackground - self.gapBackground - self.gapLabelMessage - self.imageViewWave!.frame.width : self.gapBackground + self.gapBackground + self.gapLabelMessage + self.imageViewAvatar!.frame.width)
        self.imageViewWave?.frame.origin = CGPointMake(x, y)
        
        x = x - self.gapLabelMessage - self.gapBackground
        y = y - self.gapLabelMessage - self.gapBackground
        let h = self.imageViewWave!.frame.height + 2 * self.gapLabelMessage + 2 * self.gapBackground
        var w = self.imageViewWave!.frame.width + 2 * self.gapLabelMessage + 2 * self.gapBackground
        let extraLength = self.voiceLength()
        w += extraLength
        if self.message!.ownerType == .Mine {
            x -= extraLength
        }
        self.imageViewMessageBackground?.frame = CGRectMake(x, y, w, h)
        
    }
    
    override func setMessage(message: ChatMessage) {
        super.setMessage(message)
        self.messageModel = message
        if self.message!.ownerType == .Mine {
            self.imageViewWave?.image = UIImage(named: "message_voice_sender_normal")
        } else {
            self.imageViewWave?.image = UIImage(named: "message_voice_receiver_normal")
        }
        self.imageViewWave?.sizeToFit()
    }
    
    private func voiceLength() -> CGFloat {
        let widthAlreadyUsed = self.gapPortrait + self.imageViewAvatar!.frame.width + self.gapBackground + self.gapLabelMessage + self.imageViewWave!.frame.width + self.gapLabelMessage
        let ratio = (UIScreen.mainScreen().bounds.width * 0.58 - widthAlreadyUsed) / 60
        var extraLength = ratio * CGFloat((self.message as! ChatVoiceMessage).voiceSecs)
        if extraLength > UIScreen.mainScreen().bounds.width * 0.58 - widthAlreadyUsed {
            extraLength = UIScreen.mainScreen().bounds.width * 0.58 - widthAlreadyUsed
        }
        return extraLength
    }
    
    
    func tapToPlay(recognizer: UITapGestureRecognizer) {
        self.closureVoice?()
    }
}