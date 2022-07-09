//
//  SearchBusinessRequest.swift
//  Test070422
//
//  Created by Admin on 07/07/2022.
//

import Foundation

struct SearchBusinessRequest {
    var name: String?
    var location: String?
    var latitude: Double?
    var longitude: Double?
    var cuisineType: [String]?
    var limit: Int? = 20
    var offset: Int?
    
    var url: String {
        return APIs.searchBusinesses()
    }
    
    var method: APIMethod {
        return .GET
    }
    
    var parameters: [String: Any] {
        var params: [String: Any] = [:]
        
        if let name = name, !name.isEmpty {
            params["term"] = name
        }
        if let location = location, !location.isEmpty {
            params["location"] = location
        }
        if let latitude = latitude {
            params["latitude"] = latitude
        }
        if let longitude = longitude {
            params["longitude"] = longitude
        }
        if let cuisineType = cuisineType, !cuisineType.isEmpty {
            let categories = cuisineType.joined(separator: ",")
            params["categories"] = categories
        }
        if let limit = limit {
            params["limit"] = limit
        }
        if let offset = offset {
            params["offset"] = offset
        }
        
        params["sort_by"] = "distance"
        
        return params
    }
}
