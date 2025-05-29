//
//  NotesCardView.swift
//  NotesComponents
//
//  Created by Jose Garcia on 5/3/25.
//

import SwiftUI
import NotesTheme

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
                        NotesPill(title: tag, isSelected: .constant(false), canDeselect: false)
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
                .foregroundStyle(Color.cardTextColor)
            }
            .padding(.horizontal, 17.0)
            .padding(.top, 13.0)
            .padding(.bottom, 18.0)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.cardBackgroundColor)
            )
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        .padding(.horizontal, 16.0)
        .background(Color.backgroundColor)
    }
}

#Preview {
    NotesCardView(title: "Title",
                  description: "Description",
                  date: "12-07-1997",
                  tag: "Work")
}
