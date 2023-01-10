//
//  CreateEntityView.swift
//  ToTheStore
//
//  Created by Василий on 08.01.2023.
//

import UIKit
import SnapKit

final class CreateEntityView: BaseView {
    
    // MARK: - Nested types
    
    enum State {
        case newProduct
        case newList
        
        var description: String {
            switch self {
            case .newProduct:
                return Constant.newProduct
            case .newList:
                return Constant.baseDescription
            }
        }
    }
    
    // MARK: - Properties
    
    private let descriptionLabel = UILabel(.systemFont(ofSize: 15), .gray)
    private let plusImage = UIImageView(image: Images.plus)
    
    // MARK: - Initializers
    
    init(state: State) {
        super.init(frame: .zero)
        descriptionLabel.text = state.description
    }
    
    // MARK: - Instance methods
    
    override func setup() {
        super.setup()
        addSubviews([descriptionLabel, plusImage])
        
        backgroundColor = Colors.customGray
        layer.cornerRadius = 8
        
        self.snp.makeConstraints { maker in
            maker.height.equalTo(40)
        }
        
        plusImage.snp.makeConstraints { maker in
            maker.left.equalTo(self.snp.left).offset(10)
            maker.width.height.equalTo(15)
            maker.centerY.equalTo(self)
        }
        
        descriptionLabel.snp.makeConstraints { maker in
            maker.left.equalTo(plusImage.snp.right).offset(10)
            maker.centerY.equalTo(self)
        }
    }
}
