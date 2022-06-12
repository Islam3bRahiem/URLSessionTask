//
//  HomeViewModel.swift
//  URLSessionTask
//
//  Created by Rowaad on 31/05/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModelInputs {
    func viewDidLoad()
    func contactUs()
}

protocol HomeViewModelOutputs {
    var emailTextFieldBehavior: BehaviorRelay<String> { get }
    var passwordTextFieldBehavior: BehaviorRelay<String> { get }
    var isSendButtonEnable: Observable<Bool> { get }
    var photosObservable: Observable<[ImageCellViewModel]> { get }
}

class HomeViewModel: BaseViewModel, HomeViewModelInputs, HomeViewModelOutputs {
    
    //Properties
    private let client = APIClient.shared
    private var photosBehavior: BehaviorRelay<[ImageCellViewModel]> = .init(value: [])
    private let getPhotosModel = ["method": NetworkConstants.EndPoint.search.url,
                                  "format": NetworkConstants.format,
                                  "nojsoncallback": "50",
                                  "text": "Color",
                                  "page": "1",
                                  "per_page": "50",
                                  "api_key":NetworkConstants.apiKey]
    
    private let contactUsModel = ["name": "Islam 3bRahiem",
                                  "email": "islam@yahoo.com",
                                  "subject": "Suggestion",
                                  "message": "New Suggestion"]
    
    private var isEmptyEmail: Observable<Bool> {
        return emailTextFieldBehavior.asObservable().map { (email) in
            let isEmptyEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            return isEmptyEmail
        }
    }
    private var isEmptyPassword: Observable<Bool> {
        return passwordTextFieldBehavior.asObservable().map { (password) in
            let isEmptyPassword = password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            return isEmptyPassword
        }
    }
    
    override init() {
        self.photosObservable = photosBehavior.asObservable()
    }
    
    //Outputs
    var emailTextFieldBehavior: BehaviorRelay<String> = .init(value: "")
    var passwordTextFieldBehavior: BehaviorRelay<String> = .init(value: "")
    var isSendButtonEnable: Observable<Bool> {
        return Observable.combineLatest(isEmptyEmail, isEmptyPassword) { (isEmptyEmail, isEmptyPassword) in
            return !isEmptyEmail && !isEmptyPassword
        }
    }
    var photosObservable: Observable<[ImageCellViewModel]>

    
    //Inputs
    func viewDidLoad() {
        isLoading.onNext(true)
        client.fetchData(getPhotosModel)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self](response) in
                guard let self = self else { return }
                self.isLoading.onNext(false)
                print("❤️ response : ", response)
                let photos = response.photos.photo
                let photosVewModel = photos.map(ImageCellViewModel.init)
                self.photosBehavior.accept(photosVewModel)
            } onError: { [weak self] error in
                guard let self = self else { return }
                self.isLoading.onNext(false)
                self.displayToastMessage.onNext(error.localizedDescription)
            } onCompleted: {
                print("Completed event.")
        }.disposed(by: disposeBag)
    }
    
    func contactUs() {
        isLoading.onNext(true)
        client.postData(contactUsModel)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self](response) in
                guard let self = self else { return }
                print("❤️ response : ", response)
                    self.isLoading.onNext(false)
                    if let errors = response.errors {
                        self.displayToastMessage.onNext(errors.first?.value ?? "")
                    }
            } onError: { [weak self] error in
                guard let self = self else { return }
                    self.isLoading.onNext(false)
                    self.displayToastMessage.onNext(error.localizedDescription)
            } onCompleted: {
                print("Completed event.")
        }.disposed(by: disposeBag)
    }
    
}
