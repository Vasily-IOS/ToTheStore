//
//  Navigator.swift
//  ToTheStore
//
//  Created by Василий on 08.01.2023.
//

import UIKit

final class Router: DefaultRouter {
    
    static let shared = Router()
    
    var appDelegate: AppDelegate? {
        didSet {
            setup()
        }
    }
    
    var mainTabBarController: UITabBarController?
    var navigationController: UINavigationController?
    
    private init() {}
    
    func changeTabBarVc(to index: Int) {
        if let mainTabBarController = mainTabBarController {
            mainTabBarController.selectedIndex = index
        }
    }
    
    func push(for type: VCType) {
        let vc = ViewControllerFactory.makeViewController(of: type)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func present(for type: VCType) {
        let vc = ViewControllerFactory.makeViewController(of: type)
        navigationController?.present(vc, animated: true)
    }
    
    func setUpRootViewController(rootVC: UIViewController) {
        navigationController = UINavigationController(rootViewController: rootVC)
        appDelegate?.window?.rootViewController = navigationController
    }
    
    func dismiss(_ viewController: UIViewController) {
        viewController.dismiss(animated: true)
    }
}

extension Router {
    
    private func setup() {
        mainTabBarController = ViewControllerFactory.makeViewController(of: .tabBar) as? UITabBarController
        navigationController = UINavigationController(rootViewController: mainTabBarController!)
        navigationController?.isNavigationBarHidden = true
        mainTabBarController?.selectedIndex = 0
        appDelegate?.window?.rootViewController = navigationController
        
        appDelegate?.window?.makeKeyAndVisible()
    }
}
