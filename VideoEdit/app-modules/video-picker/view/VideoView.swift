//
//  VideoView.swift
//  VideoEdit
//
//  Created by Bruno Serrano dos Santos on 07/04/20.
//  Copyright © 2020 EagleSoft. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoView: UIView {
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    var isLoop = false
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(url: URL) {
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = bounds
        playerLayer?.videoGravity = .resizeAspectFill
        if let playerLayer = self.playerLayer {
            layer.addSublayer(playerLayer)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(reachTheEndOfTheVideo(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
    }
    
    func play() {
        if player?.timeControlStatus != .playing {
            player?.play()
        }
    }
    
    func pause() {
        player?.pause()
    }
    
    func stop() {
        player?.pause()
        player?.seek(to: .zero)
    }
    
    @objc func reachTheEndOfTheVideo(_ notification: Notification) {
        if isLoop {
            player?.pause()
            player?.seek(to: .zero)
            player?.play()
        }
    }
}
