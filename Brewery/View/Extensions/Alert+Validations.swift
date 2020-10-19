//
//  Alert+Validations.swift
//  Brewery
//
//  Created by Petrescu Silviu on 10/15/20.
//

import Foundation
import UIKit

extension UIAlertController {
    class func showMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        if let window = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first {
            window.rootViewController?.present(ac, animated: true)
        }
    }
}
