//
//  ViewController.swift
//  VideoEdit
//
//  Created by Bruno Serrano dos Santos on 25/03/20.
//  Copyright © 2020 EagleSoft. All rights reserved.
//

import UIKit
import Photos
import AVKit

class VideoPickerViewController: UIViewController {
    var presenter: ViewToPresenterProtocol?
    
    let itemsInRow: CGFloat = 3
    let itemsSpace: CGFloat = 8
    
    private var _videos: Array<Video> = []
    var videos: Array<Video> {
        get { return _videos }
        set {
            _videos = newValue
            presentVideos()
        }
    }
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.decelerationRate = .fast
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.bounces = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // TODO: Start loading
        
        presenter?.startFetchingVideos()
    }
    
    private func presentVideos()
    {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension VideoPickerViewController: PresenterToViewProtocol {
    func showVideos(videos: Array<Video>) {
        self.videos = videos
    }
    
    func showFetchError(error: String) {
        let alert = UIAlertController(title: "Oops!", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension VideoPickerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoPickerViewCell", for: indexPath) as! VideoPickerViewCell
        
        let item = self.videos[indexPath.row]
        let imageManager = PHImageManager.default()
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.deliveryMode = .opportunistic
        requestOptions.resizeMode = .exact
        requestOptions.isNetworkAccessAllowed = true
        
        imageManager.requestImage(for: item.asset!, targetSize: cell.bounds.size, contentMode: .aspectFill, options: requestOptions) { (image, info) in
            DispatchQueue.main.async {
                cell.imageView.image = image
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        DispatchQueue.global().async {
//            let video = self.videos[indexPath.row]
//            PHCachingImageManager().requestAVAsset(forVideo: video.asset!, options: nil) { (asset, audioMix, info) in
//                let asset = asset as! AVURLAsset
//
//                DispatchQueue.main.async {
//                    let player = AVPlayer(url: asset.url)
//                    let playerVC = AVPlayerViewController()
//                    playerVC.player = player
//
//                    self.present(playerVC, animated: true) {
//                        player.play()
//                    }
//                }
//            }
//        }
        
        let video = self.videos[indexPath.row]

        if let playerVC = storyboard?.instantiateViewController(withIdentifier: "VideoPreviewViewController") as? VideoPreviewViewController {
            playerVC.video = video
            self.present(playerVC, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.bounds.width / itemsInRow) - itemsSpace
        return CGSize(width: size, height: size)
    }
}

class VideoPickerViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
}
