//
//  HomeViewModel.swift
//  URLSessionTask
//
//  Created by Rowaad on 31/05/2022.
//

import Foundation

protocol HomeViewModelInputs {
    func viewDidLoad()
    func contactUs()
}

protocol HomeViewModelOutputs {
    
}

class HomeViewModel: BaseViewModel, HomeViewModelInputs, HomeViewModelOutputs {
    
    //Properties
    private let client = APIClient.shared
    private let getPhotosModel = ["method": NetworkConstants.EndPoint.search.url,
                                  "format": NetworkConstants.format,
                                  "nojsoncallback": "50",
                                  "text": "Color",
                                  "page": "1",
                                  "per_page": "20",
                                  "api_key":NetworkConstants.apiKey]
    
    private let contactUsModel = ["name": "Islam 3bRahiem",
                                  "email": "islam@yahoo.com",
                                  "subject": "Suggestion",
                                  "message": "New Suggestion"]
    
    
    //Outputs
    
    
    //Inputs
    func viewDidLoad() {
        isLoading.onNext(true)
        client.fetchData(getPhotosModel)
            .subscribe { [weak self](response) in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.isLoading.onNext(false)
                }
                print("❤️ response : ", response)
            } onError: { [weak self] error in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.isLoading.onNext(false)
                    self.displayToastMessage.onNext(error.localizedDescription)
                }
            } onCompleted: {
                print("Completed event.")
        }.disposed(by: disposeBag)
    }
    
    func contactUs() {
        isLoading.onNext(true)
        client.postData(contactUsModel)
            .subscribe { [weak self](response) in
                guard let self = self else { return }
                print("❤️ response : ", response)
                DispatchQueue.main.async {
                    self.isLoading.onNext(false)
                    if let errors = response.errors {
                        self.displayToastMessage.onNext(errors.first?.value ?? "")
                    }
                }
            } onError: { [weak self] error in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.isLoading.onNext(false)
                    self.displayToastMessage.onNext(error.localizedDescription)
                }
            } onCompleted: {
                print("Completed event.")
        }.disposed(by: disposeBag)
    }
    
}
