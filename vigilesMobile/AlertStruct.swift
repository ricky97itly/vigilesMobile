//
//  AlertStruct.swift
//  
//
//  Created by Riccardo Mores on 14/05/2019.
//

import Foundation
import UIKit

struct Alert {
    static func showAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
}

print("test")
