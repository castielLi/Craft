//
//  RCAudio.swift
//  NoSmoking
//
//  Created by Rex Tsao on 12/15/15.
//  Copyright (c) 2015 Breadth. All rights reserved.
//

import Foundation
import AVFoundation

class RTAudio: NSObject {
//    private let remoteSoundUrl = "http://120.24.165.30/ShadoPanAHero.mp3"
    var remoteSoundUrl: String? {
        willSet {
            self.soundData = nil
        }
    }
    var soundFile: String?
    var useSpeaker: Bool = true
    
    private var audioSession: AVAudioSession?
    private lazy var errorPoint: NSErrorPointer? = nil
    private var recorder: AVAudioRecorder?
    private var player: AVAudioPlayer?
    // current audio playing route.
    private var currentRouteSpeaker = false
    var soundData: NSData?
    var completionHandler: (() -> Void)?
    private var timeStartRecord: Int?
    private var timeStopRecord: Int?
    
    /// Total duration of voice you recorded.
    var recordedDuration: Int? {
        get {
            return self.timeStopRecord! - self.timeStartRecord!
        }
    }
    var audioManager: RTAudioManager?
    
    override init() {
        super.init()
        if self.audioSession == nil {
            self.audioSession = AVAudioSession.sharedInstance()
        }
    }
    
    class func sharedInstance() -> RTAudio {
        struct Inner {
            static var predicate: dispatch_once_t = 0
            static var instance: RTAudio?
        }
        dispatch_once(&Inner.predicate, {
            Inner.instance = RTAudio()
        })
        return Inner.instance!
    }
    
    func startRecording(soundFileName: String) {
        var paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        self.soundFile = (paths[0] )+"/"+soundFileName

        let recordSetting: [String: AnyObject] = [
            AVFormatIDKey: NSNumber(unsignedInt: kAudioFormatLinearPCM),
            AVSampleRateKey: 4000,
            AVNumberOfChannelsKey: 1,
            AVLinearPCMBitDepthKey: 16,
            AVLinearPCMIsNonInterleaved: false,
            AVLinearPCMIsFloatKey: false,
            AVEncoderBitRateKey: 16,
            AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue,
        ]
        do {
            try self.audioSession?.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch let error as NSError {
            self.errorPoint?.memory = error
        }
        do {
            try self.audioSession?.setActive(true)
        } catch let error as NSError {
            self.errorPoint?.memory = error
        }
        
        do {
            self.recorder = try AVAudioRecorder(URL: NSURL(fileURLWithPath: self.soundFile!), settings: recordSetting)
        } catch let error as NSError {
            self.errorPoint?.memory = error
            self.recorder = nil
        }
        self.recorder?.prepareToRecord()
        self.recorder?.delegate = self
        self.recorder?.record()
        self.timeStartRecord = RTTimer.time()
    }
    
    
    func stopRecording() {
        self.recorder?.stop()
        self.timeStopRecord = RTTimer.time()
        self.soundData = NSData(contentsOfFile: self.soundFile!)
    }
    
    
    /// Attempt to play remote sound.
    ///
    /// - parameter loadingHandler: Processing before remote sound loaded.
    /// - parameter completionHandler: Processing after sound playing finished.
    func playRemote(loadingHandler: (() -> Void)?) {

        // Important: Not all the devices support proximityMonitoring.!!
        // Enable proximity monitoring.
        UIDevice.currentDevice().proximityMonitoringEnabled = true
        // If currentDevice support proximityMonitoring, add observer.
        if UIDevice.currentDevice().proximityMonitoringEnabled == true {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RTAudio.sensorStateChanged(_:)), name: "UIDeviceProximityStateDidChangeNotification", object: nil)
        }
        
        let loadedHandler = {
            self.playWithSpeakers()
        }
        self.currentRouteSpeaker = true
        self.loadSound(loadingHandler, loadedHandler: loadedHandler)
    }
    
    /// Attempt to play local sound.
    ///
    /// - parameter soundPath: Path of sound file in bundle.
    func playLocal(soundPath: String) {
        // reset player to preparing for next sound.
        self.player = nil
        // Important: Not all the devices support proximityMonitoring.!!
        // Enable proximity monitoring.
        UIDevice.currentDevice().proximityMonitoringEnabled = true
        // If currentDevice support proximityMonitoring, add observer.
        if UIDevice.currentDevice().proximityMonitoringEnabled == true {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RTAudio.sensorStateChanged(_:)), name: "UIDeviceProximityStateDidChangeNotification", object: nil)
        }
        
        let fileManager = NSFileManager.defaultManager()
        // check if file exists
        if(!fileManager.fileExistsAtPath(soundPath)) {
            print("voice file does not exist")
        } else {
            self.soundData = NSData(contentsOfFile: soundPath)
            self.playWithSpeakers()
            self.currentRouteSpeaker = true
        }
    }
    
    /// Attempt to play existed sound.
    ///
    /// - parameter data: The data of wav dound to play.
    func playExisted(data: NSData?) {
        // reset player to preparing for next sound.
        self.player = nil
        // Important: Not all the devices support proximityMonitoring.!!
        // Enable proximity monitoring.
        UIDevice.currentDevice().proximityMonitoringEnabled = true
        // If currentDevice support proximityMonitoring, add observer.
        if UIDevice.currentDevice().proximityMonitoringEnabled == true {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RTAudio.sensorStateChanged(_:)), name: "UIDeviceProximityStateDidChangeNotification", object: nil)
        }
        
        self.soundData = data
        self.playWithSpeakers()
        self.currentRouteSpeaker = true
    }
    
    /// Play sound use AVPlayer.
    ///
    /// - parameter: type This parameter used to identify the sound is local resource or net resource.
    /// - parameter: path The path for sound resource.
    func play(type: AudioItemType, path: String) {
        if self.audioManager == nil {
            self.audioManager = RTAudioManager()
        }
        self.audioManager?.prepare(type, path: path)
        self.audioManager?.setCompletionHandler(self.completionHandler)
        self.audioManager?.play(self.useSpeaker)
    }
    
    private func loadSound(loadingHandler: (() -> Void)?, loadedHandler: (() -> Void)?) {
        if self.soundData == nil {
            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
            dispatch_async(dispatch_get_global_queue(qos, 0), {
                loadingHandler?()
                let soundData = NSData(contentsOfURL: NSURL(string: self.remoteSoundUrl!)!)
                dispatch_async(dispatch_get_main_queue(), {
                    self.soundData = soundData
                    loadedHandler?()
                })
            })
        } else {
            loadedHandler?()
        }
    }
    
    private func playWithHeadphone() {
        do {
            // Only "PlayAndRecord" support Audio Session route override.(according to "http://stackoverflow.com/questions/2662585/how-to-switch-between-speaker-and-headphones-in-iphone-application")
            try self.audioSession?.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch let error as NSError {
            self.errorPoint?.memory = error
        }
        do {
            try self.audioSession?.overrideOutputAudioPort(AVAudioSessionPortOverride.None)
        } catch let error as NSError {
            self.errorPoint?.memory = error
        }
        if self.player == nil {
            do {
                self.player = try AVAudioPlayer(data: self.soundData!)
            } catch let error as NSError {
                self.errorPoint?.memory = error
                self.player = nil
            }
            self.player?.delegate = self
        }
        self.player?.prepareToPlay()
        self.player?.play()
    }
    
    private func playWithSpeakers() {
        do {
            try self.audioSession?.setCategory(AVAudioSessionCategoryPlayback)
        } catch let error as NSError {
            self.errorPoint?.memory = error
        }
        do {
            try self.audioSession?.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)
        } catch let error as NSError {
            self.errorPoint?.memory = error
        }
        
        if self.player == nil {
            do {
                self.player = try AVAudioPlayer(data: self.soundData!)
            } catch let error as NSError {
                self.errorPoint?.memory = error
                self.player = nil
            }
            self.player?.delegate = self
        }
        self.player?.prepareToPlay()
        self.player?.play()
    }
    
    // Process observation.
    func sensorStateChanged(notification: NSNotificationCenter) {
        // device is close to user
        if UIDevice.currentDevice().proximityState == true {
            do {
                try self.audioSession?.setCategory(AVAudioSessionCategoryPlayAndRecord)
            } catch let error as NSError {
                self.errorPoint?.memory = error
            }
            do {
                try self.audioSession?.overrideOutputAudioPort(AVAudioSessionPortOverride.None)
            } catch let error as NSError {
                self.errorPoint?.memory = error
            }
            self.currentRouteSpeaker = false
        } else {
            do {
                try self.audioSession?.setCategory(AVAudioSessionCategoryPlayback)
            } catch let error as NSError {
                self.errorPoint?.memory = error
            }
            do {
                try self.audioSession?.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)
            } catch let error as NSError {
                self.errorPoint?.memory = error
            }
            self.currentRouteSpeaker = true
        }
    }
    
    /// Clear cached data
    func clear() {
        self.soundFile = nil
        self.soundData = nil
    }
    
    /// Only vibrate the phone when it has been silenced.
    class func playVibrate() {
        AudioServicesPlaySystemSound(UInt32(kSystemSoundID_Vibrate))
    }
    
    class func playSystemSound(id: UInt32 = 1007) {
        AudioServicesPlaySystemSound(id)
    }
}

extension RTAudio: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        // Close proximityMonitoring when playing finished.
        UIDevice.currentDevice().proximityMonitoringEnabled = false
        self.completionHandler?()
    }
}

extension RTAudio: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        self.completionHandler?()
    }
}
