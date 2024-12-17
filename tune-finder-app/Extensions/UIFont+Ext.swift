//
//  UIFont+Ext.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 15/12/24.
//

import UIKit

extension UIFont {
    static let primaryFont: UIFont = {
        return UIFont(name: "Plus Jakarta Sans", size: 24) ?? UIFont.systemFont(ofSize: 24, weight: .bold)
    }()
    
    static let secondaryFont: UIFont = {
        return UIFont(name: "Plus Jakarta Sans", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .regular)
    }()
    
    static let buttonFont: UIFont = {
        return UIFont(name: "Circular Std", size: 13) ?? UIFont.systemFont(ofSize: 13, weight: .bold)
    }()
}
