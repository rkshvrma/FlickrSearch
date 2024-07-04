//
//  ContentView.swift
//  SearchFlicker
//
//  Created by Room on 7/3/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FlickrViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $viewModel.searchText)
                    .padding()
                
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                        ForEach(viewModel.items) { item in
                            NavigationLink(destination: DetailView(item: item)) {
                                AsyncImage(url: URL(string: item.media.m)) { image in
                                    image.resizable()
                                        .cornerRadius(8) 
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: 100, height: 100)
                            }
                        }
                    }
                }
                Spacer()
            }
        }
    }
}
