//
//  PhotoCell.swift
//  SearchFlickr
//
//  Created by Lisogonych Volodymyr on 2/6/19.
//  Copyright © 2019 java. All rights reserved.
//

import UIKit
import SDWebImage

class SearchCell: UICollectionViewCell {

    
    // MARK: -
    // MARK:  Properties
    
    @IBOutlet weak var photoImageView: UIImageView!
   
    
    // MARK: -
    // MARK:  Initializations
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.photoImageView.image = #imageLiteral(resourceName: "noimage")
    }
    
    
    // MARK: -
    // MARK:  Public method
    
    func fill(from model: Photo) {
        self.photoImageView.setImage(with: model.stringURL)
    }
    
}
