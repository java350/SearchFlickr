//
//  UICollectionView+Extensions.swift
//  API_Users
//
//  Created by Lisogonych Volodymyr on 1/12/19.
//  Copyright © 2019 java. All rights reserved.
//

import UIKit
import Foundation

extension UICollectionView {
    
    func reusableCell<T: UICollectionViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        let reuseIdentifier = String(describing: type)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? T else {
            fatalError("Failed to find cell with reuseIdentifier \"\(reuseIdentifier)\"")
        }
        
        return cell
    }
    
    func reusableCell<Result: UICollectionViewCell>(
        _ type: Result.Type,
        for indexPath: IndexPath,
        configure: (Result) -> Void
        )
        -> Result {
            let identifier = String(describing: type)
            
            let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
            (cell as? Result).map(configure)
            
            guard let resultCell = cell as? Result else {
                fatalError("\(type.description()) - Identifire doesnt set to tableView")
            }
            
            return resultCell
    }
    
    ///Registering cell from nib for its self class
    func register(cellClass: AnyClass) {
        self.register(.nib(withClass: cellClass), forCellWithReuseIdentifier: String(describing: cellClass.self))
    }
}

