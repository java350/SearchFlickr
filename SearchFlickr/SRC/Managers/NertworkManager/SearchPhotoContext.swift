//
//  SearchPhotoContext.swift
//  SearchGiphy
//
//  Created by Lisogonych Volodymyr on 1/23/19.
//  Copyright © 2019 java. All rights reserved.
//

import Foundation

typealias CompletionHandler<T: Decodable> = ((T?, URLResponse?, Error?) -> Void)?

class SearchPhotoContext {
    func execute<T: Decodable>(searchText: String, completionHandler: CompletionHandler<T>)  {
        guard let url = URL(string: Constants.Server.api) else {
            return
        }
        
        let par = RequestParameters(url: url,
                                    method: .get,
                                    headers: nil,
                                    parameters: [Constants.Server.key.method : Constants.Server.searchMethod,
                                                 Constants.Server.key.APIKey : Constants.Server.APIKey,
                                                 Constants.Server.key.tegs   : searchText,
                                                 Constants.Server.key.responsFormat: ResponsFormat.json.rawValue,
                                                 Constants.Server.key.nojsoncallback : "1"])
        URLSession
            .shared
            .dataTask(with: par, decoder: JSONDecoder()) { (data, response, error) in
                completionHandler?(data, response, error)
            }.resume()
    }
}
