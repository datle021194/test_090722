//
//  HomeVC.swift
//  Test070422
//
//  Created by Admin on 05/07/2022.
//

import UIKit
import RxCocoa

class HomeVC: BaseViewController {
    @IBOutlet weak var businessTableView: UITableView!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var advancedSearchContainerView: UIView!
    private var advancedSearchView: AdvancedSearchVC!
    private var searchButton: UIBarButtonItem!
    
    weak var coordinator: AppCoordinator?
    
    private let viewModel: HomeVM
    private let isSearchViewShowing = BehaviorRelay<Bool>(value: false)
    
    // MARK: - Lifecycle
    init(viewModel: HomeVM) {
        self.viewModel = viewModel
        super.init(nibName: "HomeVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Business"
        addSearchButton()
        addAdvancedSearchView()
        registerBusinessTableCell()
        setupDataBinding()
        observeViewStatus(from: viewModel.viewStatus)
        
        viewModel.viewDidLoad.onNext(())
        viewModel.viewDidLoad.onCompleted()
    }
    
    // MARK: - Configure UI
    private func addSearchButton() {
        searchButton = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(didTouchSearchButton(_:)))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    private func addAdvancedSearchView() {
        advancedSearchView = AdvancedSearchVC(cuisineTypes: viewModel.cuisineTypeNames)
        addChildViewController(advancedSearchView, parentView: advancedSearchContainerView)
        
        advancedSearchView
            .selectedIndex
            .bind(to: viewModel.selectCuisineIndex)
            .disposed(by: disposeBag)
        advancedSearchView
            .unselectedIndex
            .bind(to: viewModel.unselectCuisineIndex)
            .disposed(by: disposeBag)
        advancedSearchView
            .businessNameTextField
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.businessName)
            .disposed(by: disposeBag)
        advancedSearchView
            .addressTextField
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.address)
            .disposed(by: disposeBag)
        advancedSearchView
            .okButton
            .rx
            .controlEvent(.touchUpInside)
            .map({ [weak self] element in
                self?.isSearchViewShowing.accept(false)
                return element
            })
            .bind(to: viewModel.search)
            .disposed(by: disposeBag)
    }
    
    private func registerBusinessTableCell() {
        let nib = UINib(nibName: BusinessItemCell.reuseID, bundle: nil)
        businessTableView.register(nib, forCellReuseIdentifier: BusinessItemCell.reuseID)
        businessTableView.rowHeight = UITableView.automaticDimension
        businessTableView.tableFooterView = UIView()
        
        businessTableView
            .rx.itemSelected
            .map({ $0.row })
            .bind(to: viewModel.businessDetailIndex)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Events
    @objc private func didTouchSearchButton(_ sender: UIBarButtonItem) {
        let isShowing = isSearchViewShowing.value
        isSearchViewShowing.accept(!isShowing)
    }
    
    // MARK: - Data binding
    private func setupDataBinding() {
        isSearchViewShowing
            .map({ !$0 })
            .bind(to: advancedSearchContainerView.rx.isHidden)
            .disposed(by: disposeBag)
        isSearchViewShowing
            .map({ $0 ? "Close" : "Search" })
            .bind(to: searchButton.rx.title)
            .disposed(by: disposeBag)
        
        viewModel
            .businesses
            .map({ $0.count > 0 })
            .bind(to: noDataView.rx.isHidden)
            .disposed(by: disposeBag)
        viewModel
            .businesses
            .bind(to: businessTableView.rx.items(cellIdentifier: BusinessItemCell.reuseID)) { index, data, cell in
                (cell as! BusinessItemCell).businessItem = data
            }
            .disposed(by: disposeBag)
    }
}
