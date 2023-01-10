//
//  ThirdViewController.swift
//  ToTheStore
//
//  Created by Василий on 06.01.2023.
//

import UIKit
import SnapKit

final class ListsViewController: BaseViewController {
    
    // MARK: - Properties
    
    var presenter: ListsViewrPresenter!
    
    private let titleLabel = UILabel(.systemFont(ofSize: 35, weight: .medium), .black, Title.lists)
    private let addNewListView = CreateEntityView(state: .newList)
    private let emptyListLabel = UILabel(.systemFont(ofSize: 16), .black,  Constant.noListsYet)
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Router.shared.changeTabBarVc(to: 1)
        setupNavigationBar()
    }

    // MARK: - Instance methods
    
    override func setup() {
        super.setup()
        setupNavigationBar()
        setupGestureRecognizer()
        
        view.addSubviews([titleLabel, addNewListView, emptyListLabel])
        
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(45)
            maker.left.equalTo(view.snp.left).offset(20)
        }
        
        addNewListView.snp.makeConstraints { maker in
            maker.top.equalTo(titleLabel.snp.bottom).offset(20)
            maker.left.equalTo(view.snp.left).offset(20)
            maker.right.equalTo(view.snp.right).inset(20)
        }
        
        emptyListLabel.snp.makeConstraints { maker in
            maker.centerX.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Action
    
    @objc
    private func createNewListAction() {
        presenter.showAddProductView()
    }
}

extension ListsViewController {
    
    // MARK: - Instance methods
    
    private func setupGestureRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(createNewListAction))
        addNewListView.addGestureRecognizer(recognizer)
    }
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
}

extension ListsViewController: ListsViewOutput {
    
    // MARK: - ListsViewOutput methods
    
    func showAddProductView() {
        Router.shared.push(for: .newList)
    }
}
