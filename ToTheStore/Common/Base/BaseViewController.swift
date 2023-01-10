//
//  BaseViewController.swift
//  ToTheStore
//
//  Created by Василий on 06.01.2023.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
    // MARK: - Instance methods
    
    func setup() {
        view.backgroundColor = Colors.mainBackground
    }
}
