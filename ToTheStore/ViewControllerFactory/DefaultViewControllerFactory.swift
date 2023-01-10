//
//  DefaultViewControllerFactory.swift
//  ToTheStore
//
//  Created by Василий on 08.01.2023.
//

import UIKit

protocol DefaultViewControllerFactory {
    static func makeViewController(of type: VCType) -> UIViewController
}
