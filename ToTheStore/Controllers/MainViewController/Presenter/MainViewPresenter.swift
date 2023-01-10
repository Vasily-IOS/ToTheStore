//
//  BaseViewPresenter.swift
//  ToTheStore
//
//  Created by Василий on 06.01.2023.
//

import UIKit

protocol MainPresenterInput {
    var view: MainViewOutput { get set }
    init(view: MainViewOutput)
    func createNewList()
}

protocol MainViewOutput {
    func createNewList()
}

final class MainViewPresenter: MainPresenterInput {
    
    // MARK: - Properties
    
    var view: MainViewOutput
    
    // MARK: - Initializers
    
    init(view: MainViewOutput) {
        self.view = view
    }
    
    // MARK: - Instance methods
    
    func createNewList() {
        view.createNewList()
    }
}
