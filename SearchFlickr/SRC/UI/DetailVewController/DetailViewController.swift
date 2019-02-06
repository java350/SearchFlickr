//
//  DetailViewController.swift
//  SearchFlickr
//
//  Created by Lisogonych Volodymyr on 2/6/19.
//  Copyright © 2019 java. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, RootView {
    
   
    // MARK -
    // MARK: RootView
    
    typealias ViewType = DetailView
    
    
    // MARK -
    // MARK: Properties
    
    var photo: Photo?
    
    
    // MARK: -
    // MARK:  Initializations
    
    init(photo: Photo) {
        self.photo = photo
        super.init(nibName: String(describing: DetailViewController.self) , bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK -
    // MARK: life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    
    // MARK: -
    // MARK:  Private mathods
    
    private func configureView() {
        self.navigationController?.isNavigationBarHidden = false
        self.rootView?.detailPhotoImageView.setImage(with: photo?.stringURL)
    }
}
