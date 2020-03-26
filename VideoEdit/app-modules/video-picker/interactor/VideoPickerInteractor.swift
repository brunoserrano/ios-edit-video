//
//  VideoPickerInteractor.swift
//  VideoEdit
//
//  Created by Bruno Serrano dos Santos on 26/03/20.
//  Copyright © 2020 EagleSoft. All rights reserved.
//

import UIKit
import Photos

class VideoPickerInteractor: PresenterToInteractorProtocol {
    var presenter: InteractorToPresenterProtocol?
    
    func fetchVideos() {
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            startFetching()
        } else {
            PHPhotoLibrary.requestAuthorization {
                if $0 == .authorized {
                    self.startFetching()
                } else {
                    self.presenter?.videoFetchFail(message: "We need access to your photo library!")
                }
            }
        }
    }
    
    func startFetching() {
        DispatchQueue.global(qos: .userInitiated).async {
            let fetchResult = PHAsset.fetchAssets(with: .video, options: PHFetchOptions())
            
            var videos = [Video]()
            if fetchResult.count < 0 {
                DispatchQueue.main.async {
                    self.presenter?.videoFetchSuccess(videos: videos)
                }
            }
            
            fetchResult.enumerateObjects { asset, _, __ in
                let video = Video()
                video.asset = asset
                videos.insert(video, at: 0)
            }
            
            DispatchQueue.main.async {
                self.presenter?.videoFetchSuccess(videos: videos)
            }
        }
    }
}
