//
//  UIFont+Scale.swift
//  RxApp
//
//  Created by DatLe on 1/19/21.
//  Copyright © 2021 DatLe. All rights reserved.
//

import UIKit

extension UIFont {
    var scaled: UIFont {
        let currentFontSize = self.pointSize
        let scaledFontSize = ScaleByScreenSize.shared.scaleHorizontally(value: currentFontSize)
        return self.withSize(scaledFontSize)
    }
}
