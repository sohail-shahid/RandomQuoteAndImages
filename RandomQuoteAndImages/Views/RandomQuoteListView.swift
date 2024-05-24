//
//  RandomQouteListView.swift
//  RandomQuoteAndImages
//
//  Created by CRLHL-KHANNSOH2 on 07/01/2024.
//

import SwiftUI

struct RandomQuoteListView: View {
    @ObservedObject var randomQouteListViewModel: RandomQuoteListViewModel
    var body: some View {
        NavigationView {
            List (randomQouteListViewModel.randomQoutesAndImages, id: \.id) { viewModel in
                HStack (alignment: .top) {
                    Image(uiImage: viewModel.image ?? UIImage())
                        .resizable()
                        .frame(width: 120, height: 120)
                        .cornerRadius(20)
                    Text (viewModel.quote)
                }
            }
            .task {
                await randomQouteListViewModel.getRandomQoutesAndImages(count: 2)
            }
            .navigationTitle("Images & Quotes")
            .navigationBarItems(trailing: Button(action: {
                Task.init{
                    await randomQouteListViewModel.getRandomQoutesAndImageUsingAsynGroup(count: 5)
                }
            }, label: {
                Image(systemName: "arrow.clockwise.circle")
            }))
        }
    }
}

#Preview {
    RandomQuoteListView(randomQouteListViewModel: RandomQuoteListViewModel())
}
