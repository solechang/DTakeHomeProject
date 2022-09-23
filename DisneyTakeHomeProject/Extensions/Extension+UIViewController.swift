//
//  Extension+UIViewController.swift
//  DisneyTakeHomeProject
//
//  Created by Chang Woo Choi on 9/22/22.
//

import Foundation
import UIKit
extension UIViewController {
    
    func showFailed(message: String) {
        let alert = UIAlertController(title: "Failed",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(.init(title: "Ok",
                              style: .cancel))
        self.present(alert,
                     animated: true)
    }
}
