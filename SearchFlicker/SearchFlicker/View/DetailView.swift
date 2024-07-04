//
//  DetailView.swift
//  SearchFlicker
//
//  Created by Room on 7/3/24.
//

import SwiftUI

struct DetailView: View {
    let item: FlickrItem

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: item.media.m)) { image in
                    image.resizable()
                        .cornerRadius(8)
                } placeholder: {
                    Color.gray
                }
                .frame(height: 300)
                Text(item.title)
                    .font(.headline)
                Text("By \(item.author)")
                    .font(.subheadline)
                Text("Published on \(formattedDate(from: item.published))")
                    .font(.subheadline)
                Text(item.description)
                    .padding(.top)
            }
            .padding()
        }
    }

    func formattedDate(from dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            return displayFormatter.string(from: date)
        }
        return dateString
    }
}
