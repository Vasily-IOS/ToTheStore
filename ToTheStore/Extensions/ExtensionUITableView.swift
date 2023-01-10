//
//  ExtensionUITableView.swift
//  ToTheStore
//
//  Created by Василий on 08.01.2023.
//

import UIKit

extension UITableView {
    
    convenience init(dataSource: UITableViewDataSource,
                     delegate: UITableViewDelegate,
                     backGroundColor: UIColor! = .white) {
        self.init(frame: .zero)
        self.dataSource = dataSource
        self.delegate = delegate
        self.backgroundColor = backGroundColor
    }
    
    func registerCell(type: UITableViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(type, forCellReuseIdentifier: identifier ?? cellId)
    }
    
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier) as? T
    }
    
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as! T
    }
}
