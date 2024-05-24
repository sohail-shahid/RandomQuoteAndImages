//
//  RandomQouteListViewModle.swift
//  RandomQuoteAndImages
//
//  Created by CRLHL-KHANNSOH2 on 07/01/2024.
//

import Foundation
import UIKit

@MainActor
class RandomQuoteListViewModel: ObservableObject {
    @Published var randomQoutesAndImages: [RandomQuoteAndImageViewModel] = []
    
    func getRandomQoutesAndImages(count: Int) async {
        let webService = WebService()
        let models = await webService.getRandomQoutesAndImages(count: count)
        randomQoutesAndImages = models.map({ model in
            RandomQuoteAndImageViewModel(randomQuoteAndImage: model)
        })
    }
    
    func getRandomQoutesAndImageUsingAsynGroup(count: Int) async {
        let webService = WebService()
        do {
            try await withThrowingTaskGroup(of: RandomQuoteAndImageModel.self) { group in
                for _ in 1 ... count {
                    group.addTask {
                            let image =  try await webService.getImage()
                            let quote = try await webService.getQoute()
                            return RandomQuoteAndImageModel(image: image, qoute: quote)
                    }
                    
                    for try await model in group {
                        randomQoutesAndImages.append(RandomQuoteAndImageViewModel(randomQuoteAndImage: model))
                    }
                }
            }
        } catch {
            print(error)
        }
    }
}

struct RandomQuoteAndImageViewModel: Identifiable {
    let id = UUID()
    fileprivate let randomQuoteAndImage: RandomQuoteAndImageModel
    
    var image: UIImage? {
        UIImage(data: randomQuoteAndImage.image.image)
    }
    
    var quote: String {
        randomQuoteAndImage.qoute.content
    }
}

