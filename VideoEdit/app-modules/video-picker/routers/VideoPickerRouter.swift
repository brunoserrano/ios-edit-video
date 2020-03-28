//
//  VideoPickerRouter.swift
//  VideoEdit
//
//  Created by Bruno Serrano dos Santos on 26/03/20.
//  Copyright © 2020 EagleSoft. All rights reserved.
//

import UIKit

class VideoPickerRouter: PresenterToRouterProtocol {
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: .main)
    }
    
    static func createModule() -> VideoPickerViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "VideoPickerViewController") as! VideoPickerViewController
        
        let presenter = VideoPickerPresenter()
        let interactor = VideoPickerInteractor()
        let router = VideoPickerRouter()
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = viewController
        
        return viewController
    }
    
    func pushToLinkScreen(navigationController: UINavigationController) {
//        navigationController.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: true)
    }
}
