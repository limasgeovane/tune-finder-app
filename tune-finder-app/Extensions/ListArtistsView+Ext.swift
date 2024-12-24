//
//  ListArtistsView+Ext.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 24/12/24.
//

import UIKit

extension ListArtistsView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let searchText = textField.text, !searchText.isEmpty {
            delegate?.searchArtist(artistName: searchText)
        }
        return true
    }
}
