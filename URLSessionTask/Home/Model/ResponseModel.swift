//
//  ResponseModel.swift
//  URLSessionTask
//
//  Created by Rowaad on 31/05/2022.
//

import Foundation

struct GetPhotosModel: Encodable {
    var method: String
    var format: String
    var nojsoncallback: String
    var text: String
    var page: String
    var per_page: String
    var api_key: String
}

struct ResponseModel: Codable {
    var photos: PhotosModel
    var stat: String
    var code: Int?
    var message: String?
}

struct PhotosModel: Codable {
    var page, pages, perpage, total: Int
    var photo: [PhotoModel]
}

struct PhotoModel: Codable {
    var id, owner, secret, server: String
    var farm: Int
    var title: String
    var ispublic, isfriend, isfamily: Int
}
