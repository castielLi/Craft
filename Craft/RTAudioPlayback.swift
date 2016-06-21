//
//  RTAudioPlayback.swift
//  RCToolsDemo
//
//  Created by Rex Tsao on 10/5/2016.
//  Copyright © 2016 rexcao. All rights reserved.
//

import Foundation
import AVFoundation
import AudioToolbox
import MediaPlayer

enum PlaybackStatus {
    case NotStarted
    case Playing
    case Paused
    case Finished
}

class RTAudioPlayback {
    
    var currentItem: RTAudioItem?
    var player: AVPlayer?
    var status: PlaybackStatus?
    
    private var error: NSError?
    private var audioSession: AVAudioSession?
    var completionHandler: (() -> Void)?
    
    private func prepare() {
        // Maybe use AVAudioPlayer here would be better, it support delegate.
        self.player = AVPlayer(URL: self.currentItem!.url!)
//        self.player?.actionAtItemEnd = AVPlayerActionAtItemEnd.Pause
        
        self.status = .NotStarted
        self.audioSession = AVAudioSession.sharedInstance()
        
        do {
            try self.audioSession!.setCategory(AVAudioSessionCategoryPlayback)
        } catch let error as NSError {
            self.error = error
        }
        
        do {
            try self.audioSession!.setActive(true)
        } catch let error as NSError {
            self.error = error
        }
        
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RTAudioPlayback.playFinished), name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
    }
    
    func prepareItem(item: RTAudioItem) {
        self.currentItem = item
        self.prepare()
    }
    
    func play() {
        self.player?.play()
        MPRemoteCommandCenter.sharedCommandCenter().playCommand
        self.status = .Playing
    }
    
    func pause() {
        self.player?.pause()
        MPRemoteCommandCenter.sharedCommandCenter().pauseCommand
        self.status = .Paused
    }
    
    func restart() {
        self.player?.seekToTime(CMTimeMake(0, 1))
        self.status = .Playing
    }
    
    func playAtSecond(second: Int64) {
        self.player?.seekToTime(CMTimeMake(second, 1))
        self.status = .Playing
    }
    
    func remoteControlReceiveWithEvent(receiveEvent: UIEvent) {
        if receiveEvent.type == UIEventType.RemoteControl {
            switch receiveEvent.subtype {
            case UIEventSubtype.RemoteControlTogglePlayPause:
                self.play()
                break
            default:
                break
            }
        }
    }
    
    func enableProximitySensor() {
        if UIDevice.currentDevice().proximityMonitoringEnabled == false {
            // Important: Not all the devices support proximityMonitoring.!!
            // Enable proximity monitoring.
            UIDevice.currentDevice().proximityMonitoringEnabled = true
            // If currentDevice support proximityMonitoring, add observer.
            if UIDevice.currentDevice().proximityMonitoringEnabled == true {
                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RTAudioPlayback.sensorStateChanged(_:)), name: "UIDeviceProximityStateDidChangeNotification", object: nil)
            }
        }
    }
    
    func disableProximitySensor() {
        UIDevice.currentDevice().proximityMonitoringEnabled = false
    }
    
    // Process observation.
    @objc func sensorStateChanged(notification: NSNotificationCenter) {
        // device is close to user
        if UIDevice.currentDevice().proximityState == true {
            self.playWithHeadPhone()
        } else {
            self.playWithSpeaker()
        }
    }
    
    func playWithHeadPhone() {
        do {
            try self.audioSession?.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch let error as NSError {
            self.error = error
        }
        do {
            try self.audioSession?.overrideOutputAudioPort(AVAudioSessionPortOverride.None)
        } catch let error as NSError {
            self.error = error
        }
    }
    
    func playWithSpeaker() {
        do {
            try self.audioSession?.setCategory(AVAudioSessionCategoryPlayback)
        } catch let error as NSError {
            self.error = error
        }
        do {
            try self.audioSession?.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)
        } catch let error as NSError {
            self.error = error
        }
    }
    
    @objc func playFinished() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        self.disableProximitySensor()
        self.completionHandler?()
    }
}
