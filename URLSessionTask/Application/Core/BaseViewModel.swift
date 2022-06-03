//
//  BaseViewModel.swift
//  URLSessionTask
//
//  Created by Rowaad on 31/05/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModel {
    var disposeBag: DisposeBag { get }
    var isLoading: PublishSubject<Bool> { get }
    var displayToastMessage: PublishSubject<String> { get }
}

class BaseViewModel: ViewModel {
    var disposeBag = DisposeBag()
    var isLoading: PublishSubject<Bool> = .init()
    var displayToastMessage: PublishSubject<String> = .init()
}
