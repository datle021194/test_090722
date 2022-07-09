//
//  AdvancedSearchVC.swift
//  Test070422
//
//  Created by Admin on 05/07/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

//protocol AdvancedSearchDelegate: AnyObject {
//    func advancedSearchVCTouchedClose(_ advancedSearchVC: AdvancedSearchVC)
//    func advancedSearchVC(_ advancedSearchVC: AdvancedSearchVC, didSelectAtIndex index: Int)
//    func advancedSearchVC(_ advancedSearchVC: AdvancedSearchVC, didDeselectAtIndex index: Int)
//    func advancedSearchVC(_ advancedSearchVC: AdvancedSearchVC, didChangeBusinessName name: String)
//    func advancedSearchTouchedSearch(_ vc: AdvancedSearchVC)
//}

class AdvancedSearchVC: BaseViewController {
    @IBOutlet weak var businessNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cuisineTypesStackView: UIStackView!
    @IBOutlet weak var okButton: UIButton!
    
    let selectedIndex = PublishSubject<Int>()
    let unselectedIndex = PublishSubject<Int>()
    
    private let cuisineTypes: [String]
    
    init(cuisineTypes: [String]) {
        self.cuisineTypes = cuisineTypes
        super.init(nibName: "AdvancedSearchVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.4)
        configureCuisineStackView()
    }
    
    private func configureCuisineStackView() {
        for index in 0..<cuisineTypes.count {
            let label = cuisineTypeLabel(cuisineTypes[index], index: index)
            cuisineTypesStackView.addArrangedSubview(label)
        }
        cuisineTypesStackView.isHidden = false
    }
    
    private func cuisineTypeLabel(_ cuisineType: String, index: Int) -> CuisineTypeLabel {
        let label = CuisineTypeLabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.text = cuisineType
        label.isSelected = false
        label.index = index
        label
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self, label] _ in
                let isSelected = !label.isSelected
                label.isSelected = isSelected
                label.textColor = isSelected ? .blue : .black
                
                if isSelected {
                    self?.selectedIndex.onNext(label.index)
                } else {
                    self?.unselectedIndex.onNext(label.index)
                }
            })
            .disposed(by: disposeBag)
        return label
    }
}
