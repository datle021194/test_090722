//
//  BusinessRepository.swift
//  Test070422
//
//  Created by Admin on 07/07/2022.
//

import Foundation
import RxSwift

protocol BusinessRepository {
    func search(withRequest request: SearchBusinessRequest) -> Single<BasePageModel<[BusinessModel]>>
    func detail(withRequest request: BusinessDetailRequest) -> Single<BusinessDetailModel>
}
