//
//  FlickrService.swift
//  SearchFlicker
//
//  Created by Room on 7/3/24.
//

import Foundation

class FlickrService {
    
    private let session: Session
    
    init(session: Session = URLSession.shared) {
        self.session = session
    }
    
    func fetchImages(for tags: String, completion: @escaping (Result<[FlickrItem], Error>) -> Void) {
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(tags)"
        guard let url = URL(string: urlString) else { return }

        session.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(FlickrResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(response.items))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}

