//
//  Constants.swift
//  SearchGiphy
//
//  Created by Lisogonych Volodymyr on 2/06/19.
//  Copyright © 2019 java. All rights reserved.
//

import UIKit

struct Constants {
    struct Server {
        static let api = "https://api.flickr.com/services/rest/"
        
        struct key {
            static let APIKey = "api_key"
            static let method = "method"
            static let tegs = "tags"
            static let responsFormat = "format"
            static let nojsoncallback = "nojsoncallback"
        }
        
        static let searchMethod = "flickr.photos.search"
        static let APIKey = "edf3e2c6360e8e38bf05b725ceb8f520"
    }
    
    struct PhotoHistory {
        static let maxElement = 5
        static let saveKey = "searchHistory"
    }
}

enum ImageFormat {
    case Unknown, png, jpeg, jpg, gif, tiff
}

