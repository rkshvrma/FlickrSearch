//
//  Session.swift
//  SearchFlicker
//
//  Created by Room on 7/3/24.
//

import Foundation

protocol Session {
    func dataTask(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: Session {
    func dataTask(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
}
