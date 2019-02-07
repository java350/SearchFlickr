//
//  PhotoViewModel.swift
//  SearchFlickr
//
//  Created by Lisogonych Volodymyr on 2/6/19.
//  Copyright © 2019 java. All rights reserved.
//

import Foundation
import RxSwift

class PhotoViewModel {
    
    enum Event {
        case updated([Photo])
        case selected(Photo)
    }
    
    
    // MARK -
    // MARK: Public properties
    
    var models = [Photo]()
    var count: Int {
        return self.models.count
    }
    var searchHistory: [String] = []

    var events = PublishSubject<Event>()
    
    
    // MARK: -
    // MARK:  Initializations
    
    init(models: [Photo]) {
        self.models = models
        self.searchHistory = Savers.restoreStringArray(forKey: Constants.PhotoHistory.saveKey)
    }
    
    
    // MARK -
    // MARK: Public methods
    
    func removeAll() {
        self.models.removeAll()
    }
    
    func remove(model: Photo) {
        if let index = index(at: model) {
            self.models.remove(at: index)
        }
    }
    
    func add(model: Photo) {
        self.models.append(model)
    }
    
    func add(models: [Photo]) {
        for photo in models {
            self.add(model: photo)
        }
    }
    
    
    // MARK: -
    // MARK:  Private methods
    
    private func index(at photo: Photo) -> Int? {
        return self
            .models
            .firstIndex(where: { $0.id == photo.id })
    }
    
    private func appendHistory(_ element: String) {
        if searchHistory.contains(element) {
            return
        }
        if searchHistory.count >= Constants.PhotoHistory.maxElement {
            self.searchHistory.remove(at: searchHistory.count - 1)
        }
        self.searchHistory.insert(element, at: 0)
        Savers.saveStringArray(array: searchHistory, forKey: Constants.PhotoHistory.saveKey)
    }
    
    // MARK: -
    // MARK:  Public methods
    
    func searchingImage(for request: String, completed: (()->())? ) {
        SearchPhotoContext()
            .execute(searchText: request) {[unowned self] (photos: Photos?, responce, error) in
                DispatchQueue.main.async {
                    self.removeAll()
                    if error != nil {
                        print("Error \(String(describing: error))")
                        return
                    }
                    if (responce?.isSuccessCode()).default {
                        photos.map {
                            self.appendHistory(request)
                            self.events.onNext(.updated($0.photo))
                        }
                    } else {
                        print("Error \(String(describing: error))")
                    }
                    completed?()
                }
        }
    }
}
