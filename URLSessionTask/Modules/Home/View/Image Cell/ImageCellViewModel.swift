//
//  ImageCellViewModel.swift
//  URLSessionTask
//
//  Created by Rowaad on 12/06/2022.
//

import Foundation

class ImageCellViewModel {
    
    var imageURL: String
        
    //Schema:- https://farm66​{farm}​.static.flickr.com/​{server}​/​{id}​_​{secret}​.jpg
    init(_ model: PhotoModel) {
        self.imageURL = "https://farm66.static.flickr.com/\(model.server)/\(model.id)_\(model.secret).jpg"
    }

}
