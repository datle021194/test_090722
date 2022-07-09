//
//  DataExtension.swift
//  Test070422
//
//  Created by Admin on 05/07/2022.
//

import Foundation

extension Data {
    func decoded<ExpectedType: Decodable>(_ type: ExpectedType.Type) -> ExpectedType? {
        return try? JSONDecoder().decode(type, from: self)
    }
}
