//
//  WebService.swift
//  RandomQuoteAndImages
//
//  Created by CRLHL-KHANNSOH2 on 07/01/2024.
//

import Foundation
enum NetworkError: Error {
    case badUrl
    case invalidImage
    case decodingError
}
class WebService {
    func getRandomQoutesAndImages(count: Int) async -> [RandomQuoteAndImageModel] {
        var models: [RandomQuoteAndImageModel] = []
        for _ in 1 ... count {
            let image  = try? await getImage()
            let qoute = try? await getQoute()
            if image != nil && qoute != nil {
                let qouteAndImageModel = RandomQuoteAndImageModel(image: image!, qoute: qoute!)
                models.append(qouteAndImageModel)
            }
        }
        return models
    }
    
    func getImage() async throws -> ImageModel {
        if let url  = URL(string: "https://picsum.photos/200/200?uuid=\(UUID().uuidString)") {
            let (imageData, _) = try await URLSession.shared.data(from: url)
            return ImageModel(image: imageData)
        }
        throw NetworkError.invalidImage
    }
    
    func getQoute() async throws -> QouteModel {
        if let randomQuoteUrl = URL(string: "https://api.quotable.io/random") {
            let (randomQuoteData, _) = try await URLSession.shared.data(from: randomQuoteUrl)
            let quote = try JSONDecoder().decode(QouteModel.self, from: randomQuoteData)
            return quote
        }
        throw NetworkError.decodingError
    }
}
