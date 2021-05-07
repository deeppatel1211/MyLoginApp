//
//  UIVewController + Extension.swift
//  MyLoginApp
//
//  Created by ios on 04/05/21.
//

import Foundation
import UIKit

extension UITableViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UITableViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
