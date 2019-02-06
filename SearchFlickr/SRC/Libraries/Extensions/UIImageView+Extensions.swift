//
//  UIImageView+Extensions.swift
//  SearchGiphy
//
//  Created by Lisogonych Volodymyr on 1/23/19.
//  Copyright © 2019 java. All rights reserved.
//

import UIKit
import Foundation
import SDWebImage

extension UIImageView {
    func setImage(with path: String?, defaultImage: UIImage? = nil) {
        guard let path = path,
            let url = URL(string: path) else {
                DispatchQueue.main.async {
                    self.image = defaultImage
                }
                return
        }
        
        self.sd_setShowActivityIndicatorView(true)
        self.sd_setImage(with: url, placeholderImage: defaultImage) {[weak self] _, _, _, _ in
            DispatchQueue.main.async {
                self?.sd_setShowActivityIndicatorView(false)
            }
        }
    }
}
