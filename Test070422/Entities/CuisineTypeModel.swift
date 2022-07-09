//
//  CuisineTypeModel.swift
//  Test070422
//
//  Created by Admin on 05/07/2022.
//

import Foundation

struct CuisineTypeModel {
    let id: String
    let name: String
    
    static var avaibleTypes: [CuisineTypeModel] {
        return [CuisineTypeModel(id: "signature_cuisine", name: "Signature Cuisine"),
                CuisineTypeModel(id: "ottomancuisine", name: "Ottoman Cuisine"),
                CuisineTypeModel(id: "newmexican", name: "New Mexican Cuisine")]
    }
}
