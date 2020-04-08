//
//  VideoPreviewViewController.swift
//  VideoEdit
//
//  Created by Bruno Serrano dos Santos on 28/03/20.
//  Copyright © 2020 EagleSoft. All rights reserved.
//

import UIKit
import Photos

enum VideoPreviewError: Error {
    case noVideoSelected
    case wrongMediaType
}

class VideoPreviewViewController: UIViewController {
    var video: Video?
    @IBOutlet var videoView: VideoView?
    
    override func viewDidLoad() {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        do {
            try prepareVideo()
        }
        catch {
            
        }
    }
    
    func prepareVideo() throws {
        guard let video = video else { throw VideoPreviewError.noVideoSelected }
        guard video.asset?.mediaType == .video else { throw VideoPreviewError.wrongMediaType }
        
//        let options = PHVideoRequestOptions()
//        PHCachingImageManager().requestPlayerItem(forVideo: video.asset!, options: options) { (playerItem, info) in
//            playerItem?.play
//        }
        DispatchQueue.global().async {
            PHCachingImageManager().requestAVAsset(forVideo: video.asset!, options: nil) { (asset, audioMix, info) in
                let asset = asset as! AVURLAsset
                
                DispatchQueue.main.async {
                    self.videoView?.configure(url: asset.url)
                    self.videoView?.play()
                }
            }
        }
    }
}
