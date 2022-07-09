//
//  BusinessDetailRequest.swift
//  Test070422
//
//  Created by Admin on 09/07/2022.
//

import Foundation

struct BusinessDetailRequest {
    let id: String
    
    var url: String {
        return APIs.businessDetail(id: id)
    }
    
    var method: APIMethod {
        return .GET
    }
}
