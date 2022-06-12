//
//  UITableViewExtension.swift
//  URLSessionTask
//
//  Created by Rowaad on 12/06/2022.
//

import Foundation
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(nibWithClass name: T.Type, at bundleClass:AnyClass? = nil) {
        let identifier = String(describing: name)
        var bundle: Bundle?
        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }
        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }
}
