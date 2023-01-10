//
//  BaseTableViewCell.swift
//  ToTheStore
//
//  Created by Василий on 09.01.2023.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance methods
    
    func setup() {
        selectionStyle = .none
    }
}
