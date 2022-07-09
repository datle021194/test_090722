//
//  BusinessData.swift
//  Test070422
//
//  Created by Admin on 07/07/2022.
//

import Foundation

struct BusinessData: Decodable {
    let id: String
    let name: String
    let location: Location
}

extension BusinessData {
    struct Location: Decodable {
        let displayAddress: [String]
        
        enum CodingKeys: String, CodingKey {
            case displayAddress = "display_address"
        }
    }
}
