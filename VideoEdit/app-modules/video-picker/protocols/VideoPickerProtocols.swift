//
//  VideoPickerProtocols.swift
//  VideoEdit
//
//  Created by Bruno Serrano dos Santos on 25/03/20.
//  Copyright © 2020 EagleSoft. All rights reserved.
//

import UIKit

protocol ViewToPresenterProtocol: class {
    var view: PresenterToViewProtocol? { get set }
    var interactor: PresenterToInteractorProtocol? { get set }
    var router: PresenterToRouterProtocol? { get set }
    
    func startFetchingVideos()
    func showLinkScreen(navigationController: UINavigationController)
}

protocol PresenterToViewProtocol: class {
    func showVideos(videos: Array<Video>)
    func showFetchError(error: String)
}

protocol PresenterToRouterProtocol: class {
    static func createModule() -> VideoPickerViewController
    func pushToLinkScreen(navigationController: UINavigationController)
}

protocol PresenterToInteractorProtocol: class {
    var presenter: InteractorToPresenterProtocol? { get set }
    func fetchVideos()
}

protocol InteractorToPresenterProtocol {
    func videoFetchSuccess(videos: Array<Video>)
    func videoFetchFail(message: String)
}
