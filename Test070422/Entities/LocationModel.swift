//
//  LocationModel.swift
//  Test070422
//
//  Created by Admin on 06/07/2022.
//

import Foundation

struct LocationModel {
    let latitude: Double
    let longitude: Double
    
    init?(latitude: Double?, longitude: Double?) {
        guard let latitude = latitude, let longitude = longitude else {
            return nil
        }
        self.latitude = latitude
        self.longitude = longitude
    }
}
