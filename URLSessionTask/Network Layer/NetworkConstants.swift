//
//  Endpoints.swift
//  URLSessionTask
//
//  Created by Rowaad on 31/05/2022.
//

import Foundation

public class NetworkConstants {
    static let baseUrl = "https://www.flickr.com/services/rest/"
    static let testUrl = "https://pub.rh.net.sa/taghareed/backend/dev/public/api/"
    static let apiKey = "d17378e37e555ebef55ab86c4180e8dc"
    static let format = "json"
    
    // MARK: - ...  The Endpoints
    public enum EndPoint {
        case search
        case contactUs
        case details(Int)
        
        var url: String {
            switch self {
                case .search:           return "flickr.photos.search"
                case .contactUs:        return testUrl + "contact-us/submit"
                case .details(let id):  return testUrl + "details/\(id)"
            }
        }
    }
}
