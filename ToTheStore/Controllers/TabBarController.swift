//
//  ViewController.swift
//  ToTheStore
//
//  Created by Василий on 06.01.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Initializers
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TabBarController {
    
    // MARK: - TabBarController methods
    
    private func setup() {
        let mainViewController = ViewControllerFactory.makeViewController(of: .main)
        let listViewController = ViewControllerFactory.makeViewController(of: .lists)
        let settingsViewController = ViewControllerFactory.makeViewController(of: .settings)
        
        mainViewController.tabBarItem = UITabBarItem(title: TabBarConstant.home, image: TabBarImage.home, selectedImage: nil)
        listViewController.tabBarItem = UITabBarItem(title: TabBarConstant.lists, image: TabBarImage.lists, selectedImage: nil)
        settingsViewController.tabBarItem = UITabBarItem(title: TabBarConstant.settings, image: TabBarImage.settings, selectedImage: nil)
        
        UITabBar.appearance().tintColor = .black
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().itemPositioning = .automatic
        viewControllers = [mainViewController, listViewController, settingsViewController]
    }
}
