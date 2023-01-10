//
//  NewProductViewController.swift
//  ToTheStore
//
//  Created by Василий on 08.01.2023.
//

import UIKit
import SnapKit

protocol NewProductViewControllerDelegate: AnyObject {
    func touchSome(model: ProductModel)
}

final class NewProductViewController: BaseViewController {

    // MARK: - Properties
    
    private let addProductHandler: (ProductModel) -> Void
    
    private let addProductView = AddProductView()
    
    init(handler: @escaping (ProductModel) -> Void) {
        self.addProductHandler = handler
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance methods
    
    override func setup() {
        super.setup()
        setupGestureRecognizer()
        subscribeDelegate()
        view.backgroundColor = Colors.customGray
        
        view.addSubviews([addProductView])
        
        addProductView.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            maker.left.equalTo(view.snp.left).offset(20)
            maker.right.equalTo(view.snp.right).inset(20)
        }
    }
    
    private func subscribeDelegate() {
        addProductView.addProduct = self
        addProductView.closable = self
    }
    
    // MARK: - Action
    
    @objc
    private func dismissAction() {
        Router.shared.dismiss(self)
    }
}

extension NewProductViewController {
    
    // MARK: - Instance methods

    private func setupGestureRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(dismissAction))
        view.addGestureRecognizer(recognizer)
    }
}

extension NewProductViewController: AddProduct {
    
    // MARK: - Closable method
    
    func addProduct(product: ProductModel) {
        addProductHandler(product)
    }
}

extension NewProductViewController: Closable {
    
    // MARK: - Closable method
    
    func close() {
        Router.shared.dismiss(self)
    }
}
