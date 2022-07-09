//
//  BusinessDetailModel.swift
//  Test070422
//
//  Created by Admin on 09/07/2022.
//

import Foundation

struct BusinessDetailModel {
    let name: String
    let photo: String?
    let categories: [String]?
    let hoursOperation: [HourOperation]?
    let address: String?
    let phone: String?
    let rating: Double?
}

extension BusinessDetailModel {
    struct HourOperation {
        let day: Int
        let start: String?
        let end: String?
        let isOvernight: Bool
    }
}
