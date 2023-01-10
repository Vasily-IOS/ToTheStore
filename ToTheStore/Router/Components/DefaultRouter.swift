//
//  DefaultRouter.swift
//  ToTheStore
//
//  Created by Василий on 08.01.2023.
//

import UIKit

protocol DefaultRouter {
    var appDelegate: AppDelegate? { get set }
    
    func changeTabBarVc(to index: Int)
    func push(for type: VCType)
    func present(for type: VCType)
    func dismiss(_ viewController: UIViewController)
    func setUpRootViewController(rootVC: UIViewController)
}
