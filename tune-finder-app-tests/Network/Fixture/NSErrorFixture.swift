//
//  NSErrorFixture.swift
//  tune-finder-app
//
//  Created by Geovane Lima dos Santos on 25/01/25.
//

@testable import tune_finder_app
import Foundation

extension NSError {
    static func fixture(
        domain: String = "network error",
        code: Int = 897
    ) -> Self {
        .init(domain: domain, code: code)
    }
}
