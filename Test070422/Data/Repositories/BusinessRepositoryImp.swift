//
//  BusinessRepositoryImp.swift
//  Test070422
//
//  Created by Admin on 07/07/2022.
//

import Foundation
import RxSwift

class BusinessRepositoryImp: BusinessRepository {
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func search(withRequest request: SearchBusinessRequest) -> Single<BasePageModel<[BusinessModel]>> {
        let response: Single<BusinessResponseData> = apiService
            .request(url: request.url,
                     method: request.method,
                     encoding: .urlEncoding,
                     parameters: request.parameters,
                     headers: nil)
        return response
            .map({ data in
                let businessesModel = data.businesses.map({ businessData ->BusinessModel in
                    let address = businessData.location.displayAddress.joined(separator: ",")
                    return BusinessModel(id: businessData.id,
                                         name: businessData.name,
                                         address: address)
                })
                return BasePageModel(model: businessesModel, total: data.total)
            })
    }
    
    func detail(withRequest request: BusinessDetailRequest) -> Single<BusinessDetailModel> {
        let response: Single<BusinessDetailData> = apiService
            .request(url: request.url, method: request.method,
                     encoding: .urlEncoding,
                     parameters: nil,
                     headers: nil)
        return response.map({ data in
            let hoursOperation = data.hoursOperation?.first?.open.map({ hour in
                BusinessDetailModel.HourOperation(day: hour.day,
                                                  start: hour.start,
                                                  end: hour.end,
                                                  isOvernight: hour.isOvernight)
            })
            return BusinessDetailModel(name: data.name,
                                       photo: data.photo,
                                       categories: data.categories?.map({ $0.title }),
                                       hoursOperation: hoursOperation,
                                       address: data.location?.displayAddress.joined(separator: ","),
                                       phone: data.phone,
                                       rating: data.rating)
        })
    }
}
