//
//  ExtensionUIView.swift
//  ToTheStore
//
//  Created by Василий on 06.01.2023.
//

import UIKit

extension UIView {
    
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach {
            addSubview($0)
        }
    }
    
    convenience init(_ backgroundColor: UIColor? = nil, _ cornerRadius: CGFloat = 0) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
    }
}
