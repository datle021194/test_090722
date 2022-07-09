//
//  APIService.swift
//  Test070422
//
//  Created by Admin on 05/07/2022.
//

import RxSwift

enum APIMethod: String {
    case GET, PUT, POST, DELETE
}

enum ParameterEncoding {
    case jsonEncoding, urlEncoding
}

protocol APIService {
    func request<Response>(url: String,
                           method: APIMethod,
                           encoding: ParameterEncoding,
                           parameters: [String: Any]?,
                           headers: [String: String]?) -> Single<Response> where Response: Decodable
}
