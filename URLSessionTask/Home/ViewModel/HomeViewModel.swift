//
//  HomeViewModel.swift
//  URLSessionTask
//
//  Created by Rowaad on 31/05/2022.
//

import Foundation

protocol HomeViewModelInputs {
    func viewDidLoad()
}

protocol HomeViewModelOutputs {
    
}

class HomeViewModel: BaseViewModel, HomeViewModelInputs, HomeViewModelOutputs {
    
    //Properties
    private let client = APIClient.shared
    private let model = GetPhotosModel(method: NetworkConstants.EndPoint.search.rawValue,
                                       format: NetworkConstants.format,
                                       nojsoncallback: "50",
                                       text: "Color",
                                       page: "1",
                                       per_page: "20",
                                       api_key:NetworkConstants.apiKey)
    
    
    //Outputs
    
    
    //Inputs
    func viewDidLoad() {
        isLoading.onNext(true)
        do {
            try client.fetchData(model).subscribe { [weak self](response) in
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
        } catch {
            DispatchQueue.main.async {
                self.isLoading.onNext(false)
            }
            print("ERROR ...")
        }
    }
    
}
