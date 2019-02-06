//
//  UIViewController+Extensions.swift
//  API_Users
//
//  Created by Lisogonych Volodymyr on 1/13/19.
//  Copyright © 2019 java. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlertWithTitle(title: String, message : String, onDismiss: (()->())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction) in print("Youve pressed OK Button")
            
            onDismiss?()
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
