//
//  HomeVM.swift
//  Test070422
//
//  Created by Admin on 06/07/2022.
//

import Foundation
import RxSwift
import RxRelay

protocol HomeCoordinator: AnyObject {
    func toDetailScreen(businessID: String)
}

class HomeVM: BaseViewModel {
    let businesses = BehaviorRelay<[BusinessItemVM]>(value: [])
    let businessName = BehaviorRelay<String?>(value: nil)
    let address = BehaviorRelay<String?>(value: nil)
    let selectCuisineIndex = PublishSubject<Int>()
    let unselectCuisineIndex = PublishSubject<Int>()
    let viewDidLoad = PublishSubject<Void>()
    let search = PublishSubject<Void>()
    let businessDetailIndex = PublishSubject<Int>()
    
    weak var homeCoordinator: HomeCoordinator?
    
    var cuisineTypeNames: [String] {
        return cuisineTypes.map({ $0.name })
    }
    
    private let deviceRepository: DeviceLocationRepository
    private let businessRepository: BusinessRepository
    
    private var deviceLocation: LocationModel?
    private lazy var cuisineTypes = CuisineTypeModel.avaibleTypes
    private lazy var selectedCuisineTypeIds = [String]()
    private var businessModels: BasePageModel<[BusinessModel]>?
    
    init(deviceRepository: DeviceLocationRepository, businessRepository: BusinessRepository) {
        self.deviceRepository = deviceRepository
        self.businessRepository = businessRepository
        super.init()
        fetchBusinessesOnce()
        setupSearchBusinesses()
        setupCuisineTypeSelection()
        setupBusinessDetail()
    }
    
    private func fetchBusinessesOnce() {
        viewDidLoad
            .do(onNext: { [weak self] _ in self?.viewStatus.onNext(.loading) })
            .flatMapLatest({ [deviceRepository] _ in deviceRepository.getLocation() })
            .map({ [weak self] (latitude, longiture) -> LocationModel? in
                let location = LocationModel(latitude: latitude, longitude: longiture)
                self?.deviceLocation = location
                return location
            })
            .filter({ $0 != nil })
            .flatMapLatest({ [businessRepository] location -> Single<BasePageModel<[BusinessModel]>> in
                var request = SearchBusinessRequest()
                request.latitude = location!.latitude
                request.longitude = location!.longitude
                return businessRepository.search(withRequest: request)
            })
            .subscribe(onNext: { [weak self] businesses in
                self?.businessModels = businesses
                let businessItemList = businesses.model.map({ BusinessItemVM(businessModel: $0) })
                self?.businesses.accept(businessItemList)
                self?.viewStatus.onNext(.normal)
            }, onError: { [weak self] error in
                self?.businesses.accept([])
                guard let error = error as? AppErrorModel else { return }
                
                if error.statusCode == AppErrorModel.AppErrorCode.locationPermissionDenied.rawValue {
                    let message = "Can't access your location to find businesses near you."
                    self?.viewStatus.onNext(.alert(title: "Oops!", message: message))
                } else {
                    self?.viewStatus.onNext(.alert(title: nil, message: error.reason))
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupCuisineTypeSelection() {
        selectCuisineIndex
            .map({ [weak self] index in self?.cuisineTypes[index] })
            .filter({ $0 != nil })
            .subscribe(onNext: { [weak self] cuisine in
                self?.selectedCuisineTypeIds.append(cuisine!.id)
            })
            .disposed(by: disposeBag)
        
        unselectCuisineIndex
            .map({ [weak self] index in self?.cuisineTypes[index] })
            .filter({ $0 != nil })
            .subscribe(onNext: { [weak self] cuisine in
                let id = cuisine!.id
                if let index = self?.selectedCuisineTypeIds.firstIndex(where: { $0 == id }) {
                    self?.selectedCuisineTypeIds.remove(at: index)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupSearchBusinesses() {
        let requiredInputObservable = search
            .map({ [weak self] _ in (self?.deviceLocation, self?.address.value) })
            .share()
        
        // case no device location and no address
        requiredInputObservable
            .filter({ (deviceLocation, address) in
                deviceLocation == nil && (address?.isEmpty ?? true)
            })
            .subscribe(onNext: { [weak self] _ in
                let message = "Please enter address/city/postal code"
                self?.viewStatus.onNext(.alert(title: nil, message: message))
            })
            .disposed(by: disposeBag)
        
        // search with device location or address
        requiredInputObservable
            .filter({ (deviceLocation, address) in
                deviceLocation != nil || !(address?.isEmpty ?? true)
            })
            .map({ [weak self] (deviceLocation, address) in
                (deviceLocation, self?.businessName.value, address, self?.selectedCuisineTypeIds)
            })
            .map({ (deviceLocation, businessName, address, selectedCuisineTypeIds) in
                SearchBusinessRequest(name: businessName,
                                      location: address,
                                      latitude: (address?.isEmpty ?? true) ? deviceLocation?.latitude : nil,
                                      longitude: (address?.isEmpty ?? true) ? deviceLocation?.longitude : nil,
                                      cuisineType: selectedCuisineTypeIds,
                                      limit: nil,
                                      offset: nil)
            })
            .do(onNext: { [weak self] _ in self?.viewStatus.onNext(.loading) })
            .flatMapLatest({ [businessRepository] request in
                businessRepository
                    .search(withRequest: request)
                    .catchAndReturn(BasePageModel<[BusinessModel]>(model: [], total: 0))
            })
            .do(onNext: { [weak self] _ in self?.viewStatus.onNext(.normal) })
            .subscribe(onNext: { [weak self] businesses in
                self?.businessModels = businesses
                let businessItemList = businesses.model.map({ BusinessItemVM(businessModel: $0) })
                self?.businesses.accept(businessItemList)
                self?.viewStatus.onNext(.normal)
            })
            .disposed(by: disposeBag)
        
    }
    
    private func setupBusinessDetail() {
        businessDetailIndex
            .map({ [weak self] index in self?.businessModels?.model[index].id })
            .filter({ $0 != nil })
            .subscribe(onNext: { [weak self] id in
                self?.homeCoordinator?.toDetailScreen(businessID: id!)
            })
            .disposed(by: disposeBag)
    }
}
