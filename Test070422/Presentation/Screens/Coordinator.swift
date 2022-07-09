//
//  Coordinator.swift
//  RxApp
//
//  Created by DatLe on 19/01/2022.
//  Copyright © 2022 DatLe. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    var childCoordinators: [Coordinator] { get set }
    func start()
}
