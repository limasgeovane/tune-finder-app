//
//  Status.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 24/12/24.
//

import Foundation

enum Status {
    case loading(resource: String)
    case success
    case error
    case empty(resource: String)
    
    var message: String {
        switch self {
        case .loading(let resource):
            return "Buscando seus \(resource) favoritos..."
        case .success:
            return "Busca concluída com sucesso!"
        case .error:
            return "Rolou um erro na busca..."
        case .empty(let resource):
            return "Sem \(resource) por aqui... que tal uma nova busca?"
        }
    }
}
