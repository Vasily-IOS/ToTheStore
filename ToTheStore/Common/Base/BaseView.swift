//
//  BaseView.swift
//  ToTheStore
//
//  Created by Василий on 07.01.2023.
//

import UIKit

class BaseView: UIView {
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    convenience init(height: CGFloat) {
        self.init(frame: .zero)
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = .white
    }
}
