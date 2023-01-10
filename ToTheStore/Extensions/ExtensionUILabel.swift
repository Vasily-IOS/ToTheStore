//
//  ExtensionUILabel.swift
//  ToTheStore
//
//  Created by Василий on 07.01.2023.
//

import UIKit

extension UILabel {
    convenience init(_ fontSize: UIFont? = nil, _ colorOfText: UIColor? = nil, _ title: String? = nil) {
        self.init()
        font = fontSize
        textColor = colorOfText
        text = title
    }
}
