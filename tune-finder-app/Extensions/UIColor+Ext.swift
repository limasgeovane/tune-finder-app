//
//  Colors+Ext.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 15/12/24.
//

import UIKit

extension UIColor {
    static let whitePrimaryColor: UIColor = {
        return UIColor(named: "whitePrimaryColor") ?? .white
    }()
    
    static let grayPrimaryColor: UIColor = {
        return UIColor(named: "grayPrimaryColor") ?? .gray
    }()
    
    static let graySecundaryColor: UIColor = {
        return UIColor(named: "graySecundaryColor") ?? .lightGray
    }()
    
    static let greenSecondaryColor: UIColor = {
        return UIColor(named: "greenSecondaryColor") ?? .green
    }()
}
