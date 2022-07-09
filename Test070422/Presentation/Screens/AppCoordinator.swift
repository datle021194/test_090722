//
//  AppCoordinator.swift
//  RxApp
//
//  Created by DatLe on 19/01/2022.
//  Copyright © 2022 DatLe. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    private let businessRepository = BusinessRepositoryImp(apiService: AppDelegate.shared.apiService)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeVM = HomeVM(deviceRepository: DeviceLocationRepositoryImp(),
                            businessRepository: businessRepository)
        homeVM.homeCoordinator = self
        
        let homeVC = HomeVC(viewModel: homeVM)
        navigationController.pushViewController(homeVC, animated: false)
    }
}

extension AppCoordinator: HomeCoordinator {
    func toDetailScreen(businessID: String) {
        let businessDetailVM = BusinessDetailVM(businessID: businessID,
                                                businessRepository: businessRepository)
        let businessDetailVC = BusinessDetailVC(viewModel: businessDetailVM)
        navigationController.pushViewController(businessDetailVC, animated: true)
    }
}
