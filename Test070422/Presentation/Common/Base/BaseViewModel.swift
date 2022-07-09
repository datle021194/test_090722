//
//  BaseViewModel.swift
//  RxApp
//
//  Created by DatLe on 1/13/21.
//  Copyright © 2021 DatLe. All rights reserved.
//

import Foundation
import RxSwift

enum ViewStatus {
    case normal
    case loading
    case alert(title: String?, message: String)
    case dismiss
}

class BaseViewModel {
    let disposeBag = DisposeBag()
    let viewStatus = PublishSubject<ViewStatus>()
}
