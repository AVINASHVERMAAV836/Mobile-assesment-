//
//  MusicPlayerSingletonClass.swift
//  SwiftProject
//
//  Created by Admin on 08/04/24.
//

import AVFoundation
import MediaPlayer

class AudioPlayer {
    // Singleton to keep audio playing anywhere
    static let shared = AudioPlayer()
    var player: AVPlayer?
    let commandCenter = MPRemoteCommandCenter.shared()
    
    private init() {}
    
    func play(url: URL) {
        do {
            player = AVPlayer(url: url)
            guard let player = player else { return }
            player.play()
        } catch {
            print("error occurred")
        }
    }
    
    func stop() {
        player?.pause()
    }
}

extension AudioPlayer {
    //*****************************************************************
    // MARK: - Remote Command Center Controls
    //*****************************************************************
    func setupRemoteCommandCenter(enable: Bool) {
        // UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        if enable {
            commandCenter.playCommand.addTarget { [unowned self] event in
                self.player?.play()
                return .success
            }
            
            // Add handler for Pause Command
            commandCenter.pauseCommand.addTarget { [unowned self] event in
                if self.player?.rate != 0 {
                    self.player?.pause()
                    return .success
                }
                return .commandFailed
            }
            
            commandCenter.stopCommand.addTarget { [unowned self] event in
                if self.player?.rate != 0 {
                    self.player?.play()
                    return .success
                }
                return .commandFailed
            }
            
            commandCenter.togglePlayPauseCommand.addTarget { [unowned self] event in
                if self.player?.rate == 0 {
                    self.player?.play()
                } else {
                    self.player?.pause()
                }
                return .success
            }
            commandCenter.nextTrackCommand.addTarget { event in
                return .success
            }
            commandCenter.previousTrackCommand.addTarget { event in
                return .success
            }
        }
        commandCenter.pauseCommand.isEnabled = enable
        commandCenter.playCommand.isEnabled = enable
        commandCenter.stopCommand.isEnabled = enable
        commandCenter.togglePlayPauseCommand.isEnabled = enable
        commandCenter.nextTrackCommand.isEnabled = enable
        commandCenter.previousTrackCommand.isEnabled = enable
    }
}
