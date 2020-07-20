//
//  Spotify.swift
//  SpotifyControls
//
//  Created by Ford on 7/19/20.
//  Copyright © 2020 MinhTon. All rights reserved.
//

import Foundation

open class SpotifyControls: NSObject {
    
    public static var currentTrack = Track()
    
    public static var playerState: PlayerState {
        get {
            if let state = SpotifyControls.executeAppleScriptWithString("get player state") {
                //print(state)
                if let stateEnum = PlayerState(rawValue: state) {
                    return stateEnum
                }
            }
            return PlayerState.paused
        }
        
        set {
            switch newValue {
            case .paused:
                _ = SpotifyControls.executeAppleScriptWithString("pause")
            case .playing:
                _ = SpotifyControls.executeAppleScriptWithString("play")
            }
            NotificationCenter.default.post(name: Notification.Name(rawValue: InternalNotification.key), object: self)
        }
    }
    
    
    public static func playNext(_ completionHandler: (()->())? = nil){
        _ = SpotifyControls.executeAppleScriptWithString("play (next track)")
        completionHandler?()
        NotificationCenter.default.post(name: Notification.Name(rawValue: InternalNotification.key), object: self)
    }
    
    public static func playPrevious(_ completionHandler: (() -> ())? = nil){
        _ = SpotifyControls.executeAppleScriptWithString("play (previous track)")
        completionHandler?()
        NotificationCenter.default.post(name: Notification.Name(rawValue: InternalNotification.key), object: self)
    }
    
    
    public static func startSpotify(hidden: Bool = true, completionHandler: (() -> ())? = nil){
        let option: StartOptions
        switch hidden {
        case true:
            option = .withoutUI
        case false:
            option = .withUI
        }
        _ = SpotifyControls.startSpotify(option: option)
        completionHandler?()
        NotificationCenter.default.post(name: Notification.Name(rawValue: InternalNotification.key), object: self)
    }
    
    
    public static func activateSpotify(completionHandler: (() -> ())? = nil){
        _ = SpotifyControls.activateSpotify()
        completionHandler?()
        NotificationCenter.default.post(name: Notification.Name(rawValue: InternalNotification.key), object: self)
    }
    
    static func executeAppleScriptWithString(_ command: String) -> String? {
        let myAppleScript = "if application \"Spotify\" is running then tell application \"Spotify\" to \(command)"
        
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: myAppleScript) {
            return scriptObject.executeAndReturnError(&error).stringValue
        }
        return nil
    }
    
    
    enum StartOptions {
        case withUI
        case withoutUI
    }
    
    static func startSpotify(option:StartOptions) -> String? {
        let command:String;
        switch option {
        case .withoutUI:
            command = "run"
        case .withUI:
            command = "launch"
        }
        
        let myAppleScript = "if application \"Spotify\" is not running then \(command) application \"Spotify\""
        
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: myAppleScript) {
            return scriptObject.executeAndReturnError(&error).stringValue
        }
        return nil
    }
    
    static func activateSpotify() -> String? {
        
        let myAppleScript = "activate application \"Spotify\""
        
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: myAppleScript) {
            return scriptObject.executeAndReturnError(&error).stringValue
        }
        return nil
    }
    
}
