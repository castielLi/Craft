//
//  RTAudioItem.swift
//  RCToolsDemo
//
//  Created by Rex Tsao on 10/5/2016.
//  Copyright © 2016 rexcao. All rights reserved.
//

import Foundation
import AVFoundation

enum AudioItemType {
    case Remote
    case Local
}

class RTAudioItem {
    
    private var type: AudioItemType?
    var url: NSURL?
    
    var title: String?
    var album: String?
    var artist: String?
    var artwork: UIImage?
    var duration: Float64?
    var timePlayed: Float64?
    
    init(type: AudioItemType, url: NSURL) {
        self.type = type
        self.url = url
        self.retrieveMeta()
    }
    
    private func retrieveMeta() {
        let playerItem = AVPlayerItem(URL: self.url!)
        let metaData = playerItem.asset.commonMetadata
        
        for data in metaData {
            if data.commonKey! == "title" {
                self.title = data.value?.copyWithZone(nil) as? String
            } else if data.commonKey! == "albumName" {
                self.album = data.value!.copyWithZone(nil) as? String
            } else if data.commonKey! == "artist" {
                self.artist = data.value!.copyWithZone(nil) as? String
            } else if data.commonKey! == "artwork" {
                if data.keySpace! == AVMetadataKeySpaceID3 || data.keySpace! == AVMetadataKeySpaceiTunes {
                    self.artwork = UIImage(data: (data.value?.copyWithZone(nil))! as! NSData)
                }
            }
        }
    }
    
    func infoFromItem(item: AVPlayerItem) {
        self.duration = CMTimeGetSeconds(item.duration)
        self.timePlayed = CMTimeGetSeconds(item.currentTime())
    }
}
