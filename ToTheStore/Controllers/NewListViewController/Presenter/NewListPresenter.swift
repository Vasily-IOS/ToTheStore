//
//  NewListPresenter.swift
//  ToTheStore
//
//  Created by Василий on 07.01.2023.
//

import Foundation

protocol NewListPresenterInput {
    var view: NewListViewOutput { get }
    init(view: NewListViewOutput)
    func showAddProductView()
}

protocol NewListViewOutput {
    func showAddProductView()
}

final class NewListPresenter: NewListPresenterInput {
    
    var view: NewListViewOutput
    
    init(view: NewListViewOutput) {
        self.view = view
    }
    
    func showAddProductView() {
        view.showAddProductView()
    }
}
