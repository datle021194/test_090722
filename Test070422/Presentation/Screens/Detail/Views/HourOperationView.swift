//
//  HourOperationView.swift
//  Test070422
//
//  Created by Admin on 09/07/2022.
//

import UIKit

class HourOperationView: UIView {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var overnightLabel: UILabel!
    
    var viewModel: HourOperationViewVM? {
        didSet {
            dayLabel.text = viewModel?.day
            startLabel.text = viewModel?.start
            endLabel.text = viewModel?.end
            overnightLabel.text = (viewModel?.isOvernight ?? false) ? "Yes" : "No"
        }
    }
    
    static var instance: HourOperationView {
        return UINib(nibName: "HourOperationView", bundle: nil)
            .instantiate(withOwner: nil, options: nil)[0] as! HourOperationView
    }
}
