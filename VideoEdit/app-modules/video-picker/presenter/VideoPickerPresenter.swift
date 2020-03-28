//
//  VideoPickerPresenter.swift
//  VideoEdit
//
//  Created by Bruno Serrano dos Santos on 26/03/20.
//  Copyright © 2020 EagleSoft. All rights reserved.
//

import UIKit

class VideoPickerPresenter: ViewToPresenterProtocol {
    var view: PresenterToViewProtocol?
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    
    func startFetchingVideos() {
        interactor?.fetchVideos()
    }
    
    func showLinkScreen(navigationController: UINavigationController) {
        router?.pushToLinkScreen(navigationController: navigationController)
    }
}

extension VideoPickerPresenter: InteractorToPresenterProtocol {
    func videoFetchSuccess(videos: Array<Video>) {
        view?.showVideos(videos: videos)
    }
    
    func videoFetchFail(message: String) {
        view?.showFetchError(error: message)
    }
}
