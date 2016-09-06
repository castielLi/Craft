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
    /// Data of wav-format voice.
    var voiceData: NSData?
    
    private var label: UILabel?
    
    init(ownerType: MessageOwnerType, messageType: MessageType, portrait: UIImage, voiceSecs: Int , username : String?) {
        self.voiceSecs = voiceSecs
        super.init(ownerType: ownerType, messageType: messageType, portrait: portrait , username: username)
        self.cellIdentity = "voiceMessageCell"
    }

}