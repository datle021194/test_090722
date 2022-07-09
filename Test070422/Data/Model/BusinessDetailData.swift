//
//  BusinessDetailData.swift
//  Test070422
//
//  Created by Admin on 09/07/2022.
//

import Foundation

struct BusinessDetailData: Decodable {
    let name: String
    let photo: String?
    let categories: [Category]?
    let hoursOperation: [HourOpen]?
    let location: Location?
    let phone: String?
    let rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case name
        case photo = "image_url"
        case categories
        case hoursOperation = "hours"
        case location
        case phone
        case rating
    }
}

extension BusinessDetailData {
    struct Category: Decodable {
        let title: String
    }
    
    struct HourOpen: Decodable {
        let open: [HourOperation]
    }
    
    struct HourOperation: Decodable {
        let day: Int
        let start: String?
        let end: String?
        let isOvernight: Bool
        
        enum CodingKeys: String, CodingKey {
            case day
            case start
            case end
            case isOvernight = "is_overnight"
        }
    }
    
    struct Location: Decodable {
        let displayAddress: [String]
        
        enum CodingKeys: String, CodingKey {
            case displayAddress = "display_address"
        }
    }
}
