//
//  String+Ext.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 20/12/24.
//

import Foundation

extension String {
    func toBrazilianDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: date)
        }
        return self
    }
}
