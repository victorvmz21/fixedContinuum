//
//  UIViewExtension.swift
//  Continuum
//
//  Created by Victor Monteiro on 7/3/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentSimpleAlertWith(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
