//
//  BusinessDetailVM.swift
//  Test070422
//
//  Created by Admin on 09/07/2022.
//

import Foundation
import RxSwift

class BusinessDetailVM: BaseViewModel {
    let businessName = BehaviorSubject<String>(value: "")
    let businessPhoto = BehaviorSubject<String?>(value: nil)
    let address = BehaviorSubject<String>(value: "")
    let phone = BehaviorSubject<String>(value: "")
    let raing = BehaviorSubject<String>(value: "")
    let categories = BehaviorSubject<[String]?>(value: nil)
    let hoursOperation = BehaviorSubject<[HourOperationViewVM]?>(value: nil)
    let viewDidLoad = PublishSubject<Void>()
    
    private let businessID: String
    private let businessRepository: BusinessRepository
    
    init(businessID: String, businessRepository: BusinessRepository) {
        self.businessID = businessID
        self.businessRepository = businessRepository
        super.init()
        fetchBusinessDetail()
    }
    
    private func fetchBusinessDetail() {
        viewDidLoad
            .map({ [weak self] _ in self?.businessID })
            .filter({ $0 != nil })
            .do(onNext:{ [weak self] _ in self?.viewStatus.onNext(.loading) })
            .flatMapLatest({ [businessRepository] id in
                businessRepository
                    .detail(withRequest: BusinessDetailRequest(id: id!))
            })
            .subscribe(onNext: { [weak self] detail in
                self?.businessName.onNext(detail.name)
                self?.businessPhoto.onNext(detail.photo)
                self?.address.onNext("Address: \(detail.address ?? "")")
                self?.phone.onNext("Phone: \(detail.phone ?? "")")
                self?.raing.onNext((detail.rating ?? 0).description)
                self?.categories.onNext(detail.categories)
                
                let hours = detail.hoursOperation?.map({ HourOperationViewVM(hourOperation: $0) })
                self?.hoursOperation.onNext(hours)
                
                self?.viewStatus.onNext(.normal)
            }, onError: { [weak self] error in
                guard let error = error as? AppErrorModel else { return }
                self?.viewStatus.onNext(.alert(title: "Oops!", message: error.reason))
            })
            .disposed(by: disposeBag)
    }
}
