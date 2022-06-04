//
//  RequestObservable.swift
//  URLSessionTask
//
//  Created by Rowaad on 31/05/2022.
//

import Foundation
import RxSwift
import RxCocoa

public class RequestObservable {
    private lazy var jsonDecoder = JSONDecoder()
    private var urlSession: URLSession
    
    public init(config: URLSessionConfiguration = .default) {
        urlSession = URLSession(configuration: config)
    }
    
    func callAPI<T: Decodable>(request: URLRequest) -> Observable<T> {
        return Observable<T>.create { (observable) in
            let task = self.urlSession.dataTask(with: request) { data, response, error in
                if let httpsResponse = response as? HTTPURLResponse {
                    let statusCode = httpsResponse.statusCode
                    do {
                        if statusCode == 200 {
                            let object = try self.jsonDecoder.decode(T.self, from: data ?? Data())
                            observable.onNext(object)
                        } else if statusCode == 400 {
                            let object = try self.jsonDecoder.decode(T.self, from: data ?? Data())
                            observable.onNext(object)
                        } else {
                            if let error = error {
                                observable.onError(error)
                            }
                        }
                    } catch {
                        observable.onError(error)
                    }
                }
                //observer onCompleted event
                observable.onCompleted()
            }
            task.resume()
            //return our disposable
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
