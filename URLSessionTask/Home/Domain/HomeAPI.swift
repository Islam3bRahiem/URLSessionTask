//
//  HomeAPI.swift
//  URLSessionTask
//
//  Created by Rowaad on 31/05/2022.
//

import Foundation
import RxCocoa
import RxSwift

//MARK: extension for converting out RecipeModel to jsonObject
fileprivate extension Encodable {
  var dictionaryValue:[String: String?]? {
      guard let data = try? JSONEncoder().encode(self),
      let dictionary = try? JSONSerialization.jsonObject(with: data,
        options: .allowFragments) as? [String: String] else {
      return nil
    }
    return dictionary
  }
}

class APIClient {
    
    static var shared = APIClient()
    lazy var requestObservable = RequestObservable()
    
    func fetchData(_ model: GetPhotosModel) throws -> Observable<ResponseModel> {
        var components = URLComponents(string: NetworkConstants.baseUrl)!
        components.queryItems = model.dictionaryValue!.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return requestObservable.callAPI(request: request)
    }
    
    func postData(_ model: GetPhotosModel) -> Observable<ResponseModel> {
        var request = URLRequest(url: URL(string: NetworkConstants.EndPoint.search.rawValue)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = try? JSONSerialization.data(withJSONObject: model.dictionaryValue!, options: [])
        request.httpBody = body
        
        return requestObservable.callAPI(request: request)
     }

}
