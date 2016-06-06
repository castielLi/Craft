//
//  ChatVoiceMessage.swift
//  RCToolsDemo
//
//  Created by Rex Tsao on 3/2/16.
//  Copyright (c) 2016 rexcao. All rights reserved.
//

import Foundation

class ChatVoiceMessage: ChatMessage {
    var voiceURL: String?
    /// Use time to reveal how long the voice is. Here use seconds to describe the length.
    var voiceSecs: Int
    
    init(ownerType: MessageOwnerType, messageType: MessageType, portrait: UIImage, voiceSecs: Int) {
        self.voiceSecs = voiceSecs
        super.init(ownerType: ownerType, messageType: messageType, portrait: portrait)
        self.cellIdentity = "voiceMessageCell"
    }

}