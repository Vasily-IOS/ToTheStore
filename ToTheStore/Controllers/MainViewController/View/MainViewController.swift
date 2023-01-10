//
//  SecondViewController.swift
//  ToTheStore
//
//  Created by Василий on 06.01.2023.
//

import UIKit
import SnapKit

final class MainViewController: BaseViewController {
    
    var presenter: MainPresenterInput!
    
    private let baseView = UIView(Colors.customBlue, 10)
    private let plusImage = UIImageView(image: Images.plus)
    private let descriptionLabel = UILabel(.systemFont(ofSize: 16, weight: .medium), .black, Constant.baseDescription)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Router.shared.changeTabBarVc(to: 0)
        setupNavigationBar()
    }
    
    // MARK: - Action
    
    @objc
    private func createNewListAction() {
        presenter.createNewList()
    }

    // MARK: - Instance methods
    
    override func setup() {
        super.setup()
        setupNavigationBar()
        setupGestureRecognizer()
        view.addSubviews([baseView, plusImage, descriptionLabel])
        
        baseView.snp.makeConstraints { maker in
            maker.height.width.equalTo(300)
            maker.top.equalTo(view.snp.top).offset(180)
            maker.centerX.equalTo(view)
        }
        
        plusImage.snp.makeConstraints { maker in
            maker.centerX.centerY.equalTo(baseView)
        }
        
        descriptionLabel.snp.makeConstraints { maker in
            maker.centerX.equalTo(baseView)
            maker.top.equalTo(plusImage.snp.bottom).offset(40)
        }
    }
}

extension MainViewController {
    
    // MARK: - Instance methods
    
    private func setupGestureRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(createNewListAction))
        view.addGestureRecognizer(recognizer)
    }
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
}

extension MainViewController: MainViewOutput {
    
    // MARK: - MainViewOutput methods
    
    func createNewList() {
        Router.shared.push(for: .newList)
    }
}
