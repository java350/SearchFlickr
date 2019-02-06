//
//  Savers.swift
//  SearchFlickr
//
//  Created by Lisogonych Volodymyr on 2/7/19.
//  Copyright © 2019 java. All rights reserved.
//

import Foundation

class Savers {
    
    static let defaults = UserDefaults.standard
    
    static func saveStringArray(array: [String], forKey: String ) {
        defaults.set(array, forKey: forKey)
    }
    
    static func restoreStringArray(forKey: String) -> [String] {
        return defaults.stringArray(forKey: forKey) ?? [String]()
    }
}
