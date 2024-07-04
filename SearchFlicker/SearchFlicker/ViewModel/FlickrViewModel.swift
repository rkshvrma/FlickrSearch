//
//  FlickrViewModel.swift
//  SearchFlicker
//
//  Created by Room on 7/3/24.
//

import SwiftUI
import Combine

class FlickrViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var items = [FlickrItem]()
    @Published var isLoading = false

    private var cancellable: AnyCancellable?

    init() {
        self.cancellable = $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.fetchImages(for: text)
            }
    }

    func fetchImages(for keyword: String) {
        guard !keyword.isEmpty else {
            self.items = []
            return
        }

        isLoading = true
        FlickrService().fetchImages(for: keyword) { result in
            self.isLoading = false
            switch result {
            case .success(let items):
                self.items = items
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

