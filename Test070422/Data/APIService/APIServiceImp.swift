//
//  APIServiceImp.swift
//  Test070422
//
//  Created by Admin on 05/07/2022.
//

import Foundation
import RxSwift
import Alamofire

class APIServiceImp {
    static let shared = APIServiceImp()
    private var headers = ["User-Agent": "", "Authorization": "Bearer \(yelpAPIKey)"]
    private let session: Session
    
    init() {
        let monitor = ClosureEventMonitor()
        monitor.requestDidCreateURLRequest = { (request, _) in
            debugPrint("============APIService============")
            debugPrint("request: \(request)")
        }
        monitor.requestDidCompleteTaskWithError = { (request, task, error) in
            debugPrint("============APIService============")
            debugPrint("didComplete: \(request)")
            if let error = error {
                debugPrint("error: \(error)")
            }
        }
        
        session = Session(configuration: URLSessionConfiguration.default,
                          eventMonitors: [monitor])
    }
}

extension APIServiceImp: APIService {
    func request<Response>(url: String,
                           method: APIMethod,
                           encoding: ParameterEncoding,
                           parameters: [String: Any]?,
                           headers: [String: String]?) -> Single<Response> where Response: Decodable {
        let requestEncoding: Alamofire.ParameterEncoding = (encoding == .jsonEncoding) ? JSONEncoding.default : URLEncoding.default
        
        var requestHeader = self.headers
        if let headers = headers {
            headers.forEach({ (key, value) in requestHeader[key] = value })
        }
        
        return Single<Response>.create(subscribe: { [weak self] single in
            self?.session
                .request(url,
                         method: HTTPMethod(rawValue: method.rawValue),
                         parameters: parameters,
                         encoding: requestEncoding,
                         headers: HTTPHeaders(requestHeader))
                .responseData(completionHandler: { [weak self] resonse in
                    self?.handleDataResponse(resonse, result: { (result: Result<Response, AppErrorModel>) in
                        switch result {
                        case .success(let success):
                            single(.success(success))
                        case .failure(let failure):
                            single(.failure(failure))
                        }
                    })
                })
            
            return Disposables.create()
        })
    }
    
    private func handleDataResponse<DecodableResponse>(_ response: AFDataResponse<Data>,
                                                       result: @escaping (Result<DecodableResponse, AppErrorModel>) -> Void) where DecodableResponse: Decodable {
        if case .failure(let error) = response.result {
            let errorMessage = error
                .asAFError?
                .underlyingError?
                .localizedDescription ?? error.localizedDescription
            let appError = AppErrorModel(type: .system,
                                         reason: errorMessage,
                                         statusCode: nil,
                                         data: nil)
            result(.failure(appError))
            return
        }
        
        if case .success(let data) = response.result {
            // status code out of 2xx
            if let statusCode = response.response?.statusCode, !(200...299).contains(statusCode) {
                let reason = HTTPURLResponse.localizedString(forStatusCode: statusCode)
                let appError = AppErrorModel(type: .apiService,
                                             reason: reason,
                                             statusCode: statusCode,
                                             data: response.data)
                result(.failure(appError))
                return
            }
            
            // decode failed
            guard let decodedResponse = data.decoded(DecodableResponse.self) else {
                let errorCode = AppErrorModel.AppErrorCode.decodeFailed
                let appError = AppErrorModel(type: .app,
                                             reason: errorCode.localizedString,
                                             statusCode: errorCode.rawValue,
                                             data: nil)
                result(.failure(appError))
                return
            }
            
            result(.success(decodedResponse))
        }
    }
}
