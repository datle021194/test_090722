//
//  DeviceLocationRepository.swift
//  Test070422
//
//  Created by Admin on 06/07/2022.
//

import Foundation
import RxSwift

protocol DeviceLocationRepository {
    func getLocation() -> Single<(Double?, Double?)>
}
