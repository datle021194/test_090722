//
//  AppErrorModel.swift
//  Test070422
//
//  Created by Admin on 05/07/2022.
//

import Foundation

struct AppErrorModel: Error {
    let type: ErrorType
    let reason: String
    let statusCode: Int?
    let data: Data?
}

extension AppErrorModel {
    enum ErrorType {
        case system
        case app
        case apiService
    }
}

extension AppErrorModel {
    enum AppErrorCode: Int {
        case locationPermissionDenied = 100
        case decodeFailed
        
        var localizedString: String {
            switch self {
            case .locationPermissionDenied:
                return "location denied"
            case .decodeFailed:
                return "Something went wrong.(\(self.rawValue))"
            }
        }
    }
}
