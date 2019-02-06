//
//  PhotoDataSource.swift
//  SearchFlickr
//
//  Created by Lisogonych Volodymyr on 2/6/19.
//  Copyright © 2019 java. All rights reserved.
//

import Foundation

import Foundation
import UIKit

class SearchDataSource: NSObject {
    
    
    // MARK: -
    // MARK:  Properties
    
    private var viewModel: PhotoViewModel
    
    
    // MARK: -
    // MARK:  Initialization
    
    init(with viewModel: PhotoViewModel) {
        self.viewModel = viewModel
    }
    
    
    // MARK: -
    // MARK:  Public methods
    

    func configure(_ cell: SearchCell, for row: Int) -> SearchCell  {
        cell.fill(from: self.viewModel.models[row])
        
        return cell
    }

}

extension SearchDataSource: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.reusableCell(SearchCell.self, for: indexPath)
    
        return self.configure(cell, for: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self
            .viewModel
            .events
            .onNext(.selected(self.viewModel.models[indexPath.row]))
    }
}
