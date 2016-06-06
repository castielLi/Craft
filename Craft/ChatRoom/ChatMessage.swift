//
//  ChatMessage.swift
//  RCToolsDemo
//
//  Created by Rex Tsao on 3/2/16.
//  Copyright (c) 2016 rexcao. All rights reserved.
//

import Foundation

enum MessageType: Int {
    case Text = 0
    case Voice = 1
}

enum MessageOwnerType: Int {
    case Mine = 0
    case Other = 1
}

class ChatMessage {
    var portrait: UIImage
    var ownerType: MessageOwnerType
    var messageType: MessageType
    /// Time when message sent. May be optional?
    var date: String?
    var cellIdentity: String = "textMessageCell"
    
    init(ownerType: MessageOwnerType, messageType: MessageType, portrait: UIImage) {
        self.ownerType = ownerType
        self.messageType = messageType
        self.portrait = portrait
    }
}