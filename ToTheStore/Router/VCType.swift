//
//  VCType.swift
//  ToTheStore
//
//  Created by Василий on 07.01.2023.
//

import Foundation

enum VCType {
    case tabBar
    case main
    case newList
    case lists
    case settings
    case newProduct((ProductModel) -> Void)
}
