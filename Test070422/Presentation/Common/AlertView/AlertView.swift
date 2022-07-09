//
//  AlertView.swift
//  RxApp
//
//  Created by DatLe on 3/1/21.
//  Copyright © 2021 DatLe. All rights reserved.
//

import UIKit

protocol AlertView {
    func show(in vc: UIViewController,
              title: String?,
              message: String,
              cancelTitle: String?,
              cancelAction: (() -> Void)?,
              okTitle: String?,
              okAction: (() -> Void)?)
    func actionSheet(in vc: UIViewController,
                     title: String?,
                     message: String,
                     actions: [(String, (() -> Void)?)])
    func dismiss()
}
