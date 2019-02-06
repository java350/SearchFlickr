//
//  MainViewController.swift
//  SearchFlickr
//
//  Created by Lisogonych Volodymyr on 2/6/19.
//  Copyright © 2019 java. All rights reserved.
//

import UIKit
import RxSwift
import DropDown

class SearchViewController: UIViewController, RootView, UISearchBarDelegate {
    
    
    // MARK -
    // MARK: RootView
    
    typealias ViewType = SearchView
    
    
    // MARK -
    // MARK: Properties
    let dropDown = DropDown()
    
    private var dataSource: SearchDataSource
    var viewModel: PhotoViewModel?
    
    var events: PublishSubject<Void> = PublishSubject<Void>()
    var disposeBag = DisposeBag()

    
    // MARK -
    // MARK: life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.configureSearchBar()
        self.configureDropDown()
        self.bind()
    }
    
    
    // MARK: -
    // MARK:  Initializations
    
    init(viewModel: PhotoViewModel) {
        self.viewModel = viewModel
        self.dataSource = SearchDataSource(with: viewModel)
        
        super.init(nibName: String(describing: SearchViewController.self) , bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: -
    // MARK:  Private methods
    
    private func bind() {
        self.viewModel?
            .events
            .subscribe(
                onNext: { [weak self] events in
                    switch events {
                    case .updated(let photos):
                        self?.viewModel?.add(models: photos)
                        self?
                            .rootView?
                            .collactionView.reloadData()
                    case .selected(let photo):
                        self?.showDetailViewControoler(photo: photo)
                    }
            })
            .disposed(by: disposeBag)
    }
    
    private func configureView() {
        self.definesPresentationContext = true
        
        let colectionView = self.rootView?.collactionView
        colectionView?.register(cellClass: SearchCell.self)
        colectionView?.dataSource = self.dataSource
        colectionView?.delegate = self.dataSource
    }
    
    private func configureSearchBar()  {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configureDropDown() {
        dropDown.anchorView = self.rootView?.collactionView
        dropDown.dataSource =  viewModel?.searchHistory ?? []
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            let searchBar = self.navigationItem.searchController?.searchBar
            searchBar?.text = item
            searchBar?.endEditing(true)
            self.searchingImage(for: item)
            self.dropDown.hide()
        }
    }
    
    private func searchingImage(for request: String) {
        self.viewModel?.searchingImage(for: request) { [unowned self] in
            self.dropDown.dataSource = self.viewModel?.searchHistory ?? []
        }
    }
    
    private func showDetailViewControoler(photo: Photo)  {
        let detailController = DetailViewController(photo: photo)
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}


extension SearchViewController {
    
    
    // MARK: -
    // MARK:  UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text.map( self.searchingImage )
        searchBar.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        dropDown.show()
    }
}
