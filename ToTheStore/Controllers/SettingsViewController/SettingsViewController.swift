//
//  FouthViewController.swift
//  ToTheStore
//
//  Created by Василий on 06.01.2023.
//

import UIKit
import SnapKit

class SettingsViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel(.systemFont(ofSize: 35, weight: .medium), .black, Title.settings)
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Router.shared.changeTabBarVc(to: 2)
    }
    
    // MARK: - Instance methods
    
    override func setup() {
        super.setup()
        setupNavigationBar()
        
        view.addSubviews([titleLabel])
        
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(45)
            maker.left.equalTo(view.snp.left).offset(20)
        }
        
    }
}

extension SettingsViewController {
    
    // MARK: - Instance methods
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
}
