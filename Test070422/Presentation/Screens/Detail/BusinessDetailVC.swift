//
//  BusinessDetailVC.swift
//  Test070422
//
//  Created by Admin on 09/07/2022.
//

import UIKit
import RxKingfisher

class BusinessDetailVC: BaseViewController {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoriesStackView: UIStackView!
    @IBOutlet weak var hoursStackView: UIStackView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    private let viewModel: BusinessDetailVM
    
    init(viewModel: BusinessDetailVM) {
        self.viewModel = viewModel
        super.init(nibName: "BusinessDetailVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Business detail"
        addBackButton()
        setupDataBinding()
        observeViewStatus(from: viewModel.viewStatus)
        
        viewModel.viewDidLoad.onNext(())
        viewModel.viewDidLoad.onCompleted()
    }
    
    private func setupDataBinding() {
        viewModel
            .businessName
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel
            .businessPhoto
            .filter({ url in url != nil && !url!.isEmpty })
            .map({ URL(string: $0!) })
            .bind(to: photoImageView.kf.rx.image())
            .disposed(by: disposeBag)
        viewModel
            .address
            .bind(to: addressLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel
            .phone
            .bind(to: phoneLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel
            .raing
            .bind(to: ratingLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel
            .categories
            .filter({ $0 != nil })
            .subscribe(onNext: { [weak self] categories in
                let categoryLabels = categories?.map({ category -> UILabel in
                    let label = UILabel()
                    label.font = .systemFont(ofSize: 14)
                    label.text = category
                    return label
                })
                if let categoryLabels = categoryLabels {
                    categoryLabels.forEach({ self?.categoriesStackView.addArrangedSubview($0) })
                    self?.categoriesStackView.isHidden = false
                }
            })
            .disposed(by: disposeBag)
        viewModel
            .hoursOperation
            .subscribe(onNext: { [weak self] hours in
                let hourViews = hours?.map({ hour -> HourOperationView in
                    let hourView = HourOperationView.instance
                    hourView.viewModel = hour
                    return hourView
                })
                if let hourViews = hourViews {
                    hourViews.forEach({ view in self?.hoursStackView.addArrangedSubview(view) })
                    self?.hoursStackView.isHidden = false
                }
            })
            .disposed(by: disposeBag)
    }
}
