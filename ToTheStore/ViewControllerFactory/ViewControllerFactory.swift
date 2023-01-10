//
//  ViewControllerFactory.swift
//  ToTheStore
//
//  Created by Василий on 07.01.2023.
//

import UIKit

final class ViewControllerFactory: DefaultViewControllerFactory {
    
    // MARK: - DefaultViewControllerFactory method
    
    static func makeViewController(of type: VCType) -> UIViewController {
        switch type {
        case .tabBar:
            return TabBarController()
        case .main:
            let mainViewController = MainViewController()
            let presenter = MainViewPresenter(view: mainViewController)
            mainViewController.presenter = presenter
            return mainViewController
        case .lists:
            let view = ListsViewController()
            let presenter = ListsViewrPresenter(view: view)
            view.presenter = presenter
            return view
        case .settings:
            let vc = SettingsViewController()
            return vc
        case .newList:
            let view = NewListViewController()
            let presenter = NewListPresenter(view: view)
            view.presenter = presenter
            return view 
        case .newProduct(let handler):
            let vc = NewProductViewController(handler: handler)
            return vc
        }
    }
}
