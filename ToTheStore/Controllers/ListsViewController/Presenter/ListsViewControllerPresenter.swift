//
//  ListsViewControllerPresenter.swift
//  ToTheStore
//
//  Created by Василий on 08.01.2023.
//

import Foundation

protocol ListsPresenterInput {
    var view: ListsViewOutput { get }
    init(view: ListsViewOutput)
    func showAddProductView()
}

protocol ListsViewOutput {
    func showAddProductView()
}

final class ListsViewrPresenter: ListsPresenterInput {
    
    // MARK: - Properties
    
    var view: ListsViewOutput
    
    // MARK: - Initializers
    
    init(view: ListsViewOutput) {
        self.view = view
    }
    
    // MARK: - Instance methods
    
    func showAddProductView() {
        view.showAddProductView()
    }
}
