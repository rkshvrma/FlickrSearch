//
//  MockSession.swift
//  SearchFlickerTests
//
//  Created by Room on 7/3/24.
//

import Foundation
@testable import SearchFlicker

class MockSession: Session {
    func dataTask(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = Bundle(for: Self.self).url(forResource: "MockData", withExtension: "json") else {
            completion(nil, nil, NSError(domain: "Testing Error", code: 0))
            return
        }
        do {
            let data = try Data(contentsOf: url)
            completion(data, nil, nil)
        } catch {
            print(error)
            completion(nil, nil, error)
        }
    }
}
