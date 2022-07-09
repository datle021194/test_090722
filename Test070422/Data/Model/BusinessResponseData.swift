//
//  BusinessResponseData.swift
//  Test070422
//
//  Created by Admin on 07/07/2022.
//

import Foundation

struct BusinessResponseData: Decodable {
    let businesses: [BusinessData]
    let total: Int
}
