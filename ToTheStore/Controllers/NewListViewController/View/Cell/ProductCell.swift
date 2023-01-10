//
//  ProductCell.swift
//  ToTheStore
//
//  Created by Василий on 09.01.2023.
//

import UIKit
import SnapKit

final class ProductCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    private let productLabel = UILabel()
    private let amountaLabel = UILabel()
    private let separatorView = UIView(Colors.customGray)
    
    // MARK: - Configuration
    
    func configure(_ model: ProductModel) {
        productLabel.text = model.product
        amountaLabel.text = model.amount
    }
    
    // MARK: - Instance methods
    
    override func setup() {
        super.setup()
        contentView.addSubviews([productLabel, amountaLabel, separatorView])
        
        contentView.layer.cornerRadius = 10
        
        productLabel.snp.makeConstraints { maker in
            maker.left.equalTo(contentView.snp.left).offset(10)
            maker.centerY.equalTo(self)
        }
        
        amountaLabel.snp.makeConstraints { maker in
            maker.right.equalTo(contentView.snp.right).inset(30)
            maker.centerY.equalTo(self)
        }
        
        separatorView.snp.makeConstraints { maker in
            maker.height.equalTo(1)
            maker.left.bottom.right.equalTo(contentView)
        }
    }
}
