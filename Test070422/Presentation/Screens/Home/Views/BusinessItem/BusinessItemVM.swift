//
//  BusinessItemVM.swift
//  Test070422
//
//  Created by Admin on 07/07/2022.
//

import Foundation

struct BusinessItemVM {
    let name: String?
    let address: String?
    
    init(businessModel: BusinessModel) {
        name = businessModel.name
        address = businessModel.address
    }
}
