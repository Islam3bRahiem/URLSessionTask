//
//  HomeAPI.swift
//  URLSessionTask
//
//  Created by Rowaad on 31/05/2022.
//

import Foundation
import RxCocoa
import RxSwift


class APIClient {
    
    static var shared = APIClient()
    lazy var requestObservable = RequestObservable()
    
    func fetchData(_ dic: [String:Any]) -> Observable<ResponseModel> {
        var components = URLComponents(string: NetworkConstants.baseUrl)!
        components.queryItems = dic.compactMap { (key, value) in
            URLQueryItem(name: key, value: "\(value)")
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return requestObservable.callAPI(request: request)
    }
    
    func postData(_ dic: [String:Any]) -> Observable<PostDataResponse> {
        var request = URLRequest(url: URL(string: NetworkConstants.EndPoint.contactUs.url)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("ios", forHTTPHeaderField: "os")
        request.addValue("Bearer 6293871a4bfaf72d293ae904|BpUzH5oX52KjHhcOQWUzOFKp4V6LxHc03LOpkDd8", forHTTPHeaderField: "Authorization")
                
        let body = (dic.compactMap({ (key, value) -> String in
                    return "\(key)=\(value)"
                    }) as Array).joined(separator: "&")
        let bodyData = body.data(using: String.Encoding.utf8)
        request.httpBody = bodyData

        return requestObservable.callAPI(request: request)
     }

}
