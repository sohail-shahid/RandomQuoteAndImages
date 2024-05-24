//
//  RandomQouteModel.swift
//  RandomQuoteAndImages
//
//  Created by CRLHL-KHANNSOH2 on 07/01/2024.
//

import Foundation
struct RandomQuoteAndImageModel {
    let image: ImageModel
    let qoute: QouteModel
}

struct QouteModel: Codable {
    var id: String
    var author: String
    var content: String
    var tags: [String]
    var authorSlug: String
    var length: Int
    var dateAdded: String
    var dateModified: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id", author, content, tags, authorSlug, length, dateAdded, dateModified
    }
}

struct ImageModel: Codable {
    var image: Data
    
    enum CodingKeys: String, CodingKey {
        case image
    }
}
