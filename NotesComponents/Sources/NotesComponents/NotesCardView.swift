//
//  NotesCardView.swift
//  NotesComponents
//
//  Created by Jose Garcia on 5/3/25.
//

import SwiftUI

public struct NotesCardView: View {
    let title: String
    let description: String
    let date: String
    let tag: String?
    
    public init(title: String, description: String, date: String, tag: String?) {
        self.title = title
        self.description = description
        self.date = date
        self.tag = tag
    }
    
    public var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    if let tag = tag {
                        Text(tag)
                            .font(.body)
                            .foregroundColor(Color.blue)
                            .padding(.vertical, 6)
                            .background(
                                Capsule()
                                    .fill(Color(red: 32/255, green: 40/255, blue: 55/255))
                            )
                    }
            
                    Text(title)
                        .font(.title)
                        .padding(.bottom, 8.0)
                    Text(description)
                        .padding(.bottom, 10.0)
                    Text(date)
                        .padding(.bottom, 18.0)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 17.0)
            .padding(.top, 13.0)
            .padding(.bottom, 18.0)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(red: 0.13, green: 0.14, blue: 0.15))
            )
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        .padding(.horizontal, 16.0)
        .background(Color(red: 15/255, green: 17/255, blue: 21/255))
    }
}

#Preview {
    NotesCardView(title: "Title",
                  description: "Description",
                  date: "12-07-1997",
                  tag: "Work")
}
