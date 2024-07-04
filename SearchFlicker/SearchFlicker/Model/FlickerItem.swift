//
//  FlickerItem.swift
//  SearchFlicker
//
//  Created by Room on 7/3/24.
//

import Foundation

struct FlickrItem: Codable, Identifiable {
    let id = UUID()
    let title: String
    let media: Media
    let author: String
    let description: String
    let published: String
}

struct Media: Codable {
    let m: String
}

