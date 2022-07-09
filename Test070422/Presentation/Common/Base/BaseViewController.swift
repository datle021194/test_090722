//
//  BaseViewController.swift
//  RxApp
//
//  Created by DatLe on 1/13/21.
//  Copyright © 2021 DatLe. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    private(set) lazy var disposeBag = DisposeBag()
    private(set) lazy var loadingView: LoadingView = LoadingViewImp.shared
    private(set) lazy var alertView: AlertView = AlertViewImp()
    
    private var customBackAction: (() -> Void)?
    
    // MARK: - Lifecycle
    deinit {
        let thisType = type(of: self)
        let className = String(describing: thisType)
        debugPrint("\(className) will be deallocated")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    // MARK: - Public
    func observeViewStatus(from observable: Observable<ViewStatus>) {
        observable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] viewStatus in
                guard let weakSelf = self else { return }
                
                switch viewStatus {
                case .normal:
                    weakSelf.loadingView.hide()
                    weakSelf.alertView.dismiss()
                case .loading:
                    weakSelf.alertView.dismiss()
                    weakSelf.loadingView.show()
                case .alert(let title, let message):
                    weakSelf.loadingView.hide()
                    weakSelf.alertView.show(
                        in: weakSelf,
                        title: title,
                        message: message,
                        cancelTitle: nil,
                        cancelAction: nil,
                        okTitle: "OK",
                        okAction: nil
                    )
                case .dismiss:
                    weakSelf.loadingView.hide()
                    weakSelf.dismiss(animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func addBackButton(color: UIColor? = .black, backAction: (() -> Void)? = nil) {
        customBackAction = backAction
        
        navigationItem.hidesBackButton = true
        
        let backButton = UIBarButtonItem(
            image: UIImage(named: "ic_back"),
            style: .plain,
            target: self,
            action: #selector(self.didTouchBackButton)
        )
        backButton.tintColor = color
        
        navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK: - Private
    private func commonInit() {
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
    }
    
    @objc private func didTouchBackButton() {
        if let customBackAction = customBackAction {
            customBackAction()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
