//
//  DeviceLocationRepositoryImp.swift
//  Test070422
//
//  Created by Admin on 06/07/2022.
//

import Foundation
import RxSwift
import CoreLocation

class DeviceLocationRepositoryImp: NSObject {
    private var locationManager: CLLocationManager?
    private var single: ((Result<(Double?, Double?), Error>) -> Void)?
}

extension DeviceLocationRepositoryImp: DeviceLocationRepository {
    func getLocation() -> Single<(Double?, Double?)> {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        
        return Single<(Double?, Double?)>.create(subscribe: { [weak self] single in
            self?.single = single
            return Disposables.create()
        })
    }
}

extension DeviceLocationRepositoryImp: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted {
            let errorCode = AppErrorModel.AppErrorCode.locationPermissionDenied
            let error = AppErrorModel(type: .app,
                                      reason: errorCode.localizedString,
                                      statusCode: errorCode.rawValue,
                                      data: nil)
            single?(.failure(error))
        } else if status == .authorizedWhenInUse || status == .authorizedAlways {
            let coordinate = manager.location?.coordinate
            single?(.success((coordinate?.latitude, coordinate?.longitude)))
        }
    }
}
