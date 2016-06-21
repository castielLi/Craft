//
//  RTAudioManager.swift
//  RCToolsDemo
//
//  Created by Rex Tsao on 10/5/2016.
//  Copyright © 2016 rexcao. All rights reserved.
//

import Foundation

class RTAudioManager {
    
    var player: RTAudioPlayback?
//    var useSpeaker: Bool = true {
//        willSet {
//            if newValue {
//                self.player?.enableProximitySensor()
//            } else {
//                self.player?.disableProximitySensor()
//            }
//        }
//    }
    
    func prepare(type: AudioItemType, path: String, enableProxymitySensor: Bool = true) {
        
        var url: NSURL?
        if type == .Remote {
            url = NSURL(string: path)
        } else  {
            url = NSURL(fileURLWithPath: path)
        }
        
        let item = RTAudioItem(type: type, url: url!)
        
        if self.player == nil {
            self.player = RTAudioPlayback()
        }
        self.player?.prepareItem(item)
        if enableProxymitySensor {
            self.player?.enableProximitySensor()
        }
    }
    
    func play(useSpeaker: Bool) {
        self.player?.play()
        if useSpeaker {
            self.player?.enableProximitySensor()
            self.speaker()
        } else {
            self.player?.disableProximitySensor()
            self.headPhone()
        }
    }
    
    func pause() {
        self.player?.pause()
    }
    
    func setCompletionHandler(handler: (() -> Void)?) {
        // Disclosure to force user to specify the handler.
        self.player!.completionHandler = handler
    }
    
    private func headPhone() {
        self.player?.playWithHeadPhone()
    }
    
    private func speaker() {
        self.player?.playWithSpeaker()
    }
}
