//
//  APIs.swift
//  Test070422
//
//  Created by Admin on 08/07/2022.
//

import Foundation

struct APIs {
    static let baseURL = "https://api.yelp.com/v3"
    
    static func searchBusinesses() -> String {
        return "\(baseURL)/businesses/search"
    }
    
    static func businessDetail(id: String) -> String {
        return "\(baseURL)/businesses/\(id)"
    }
}
