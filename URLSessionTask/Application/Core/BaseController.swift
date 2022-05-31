//
//  BaseController.swift
//  URLSessionTask
//
//  Created by Rowaad on 31/05/2022.
//

import Foundation
import UIKit
import RxSwift

protocol BaseControllerFunctions {
    func makeAlert(with message: String)
}

class BaseController<T: BaseViewModel>: UIViewController, ActivityIndicatorPresenter {
    
    var viewModel: T
    lazy var disposeBag: DisposeBag = {
       return DisposeBag()
    }()
    var activityIndicator = UIActivityIndicatorView()
    
    init(_ viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel: viewModel)
        bindStates()
    }
    
    func bind(viewModel: T) {
        fatalError("Please override bind function")
    }
    
    private func bindStates() {
        viewModel.isLoading.subscribe { [weak self] (isLoading) in
            guard let self = self,
            let isLoading = isLoading.element else { return }
            if isLoading {
                self.showActivityIndicator()
            } else {
                self.hideActivityIndicator()
            }
        }.disposed(by: disposeBag)
        
        viewModel.displayToastMessage.subscribe { [weak self](message) in
            guard let self = self,
            let message = message.element else { return }
            self.makeAlert(with: message)
        }.disposed(by: disposeBag)
    }
    
}

extension BaseController: BaseControllerFunctions {
    func makeAlert(with message: String) {
        let alert = UIAlertController(title: "Alert !", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}


