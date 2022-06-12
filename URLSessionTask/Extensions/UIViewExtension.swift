//
//  UIViewExtension.swift
//  URLSessionTask
//
//  Created by Rowaad on 12/06/2022.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRaduis: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor ?? UIColor.black.cgColor)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
