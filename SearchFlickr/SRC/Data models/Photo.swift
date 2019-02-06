//
//  Photo.swift
//  SearchFlickr
//
//  Created by Lisogonych Volodymyr on 2/6/19.
//  Copyright © 2019 java. All rights reserved.
//

import Foundation

class Photo: Decodable {
    var id: String
    var secret: String
    var server: String
    var farm: Int
    var title: String
    var request: String?
}

extension Photo {
    var stringURL: String {
        return "https://farm\(farm).staticflickr.com/" + server + "/" + id + "_" + secret + ".\(ImageFormat.jpg)"
    }
}

struct Photos: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case page
        case pages
        case perpage
        case photo
    }
    
    enum ProductKeys: String, CodingKey {
        case photos
    }
    
    let page: Int
    let pages: Int
    let perpage: Int
    let photo: [Photo]
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ProductKeys.self)
        let photosValues = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .photos)
        page = try photosValues.decode(Int.self, forKey: .page)
        pages = try photosValues.decode(Int.self, forKey: .pages)
        perpage = try photosValues.decode(Int.self, forKey: .perpage)
        photo = try photosValues.decodeIfPresent([Photo].self, forKey: .photo) ?? []
    }
}

