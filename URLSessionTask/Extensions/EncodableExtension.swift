//
//  EncodableExtension.swift
//  URLSessionTask
//
//  Created by Rowaad on 04/06/2022.
//

import Foundation

//MARK: extension for converting out RecipeModel to jsonObject
extension Encodable {
  var dictionaryValue:[String: Any] {
      guard let data = try? JSONEncoder().encode(self),
      let dictionary = try? JSONSerialization.jsonObject(with: data,
                                                         options: .allowFragments ) as? [String: String] else {
          return [:]
    }
    return dictionary
  }
}
