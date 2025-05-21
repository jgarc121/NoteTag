//
//  NotesListView.swift
//  notes-app
//
//  Created by Jose Garcia on 5/20/25.
//

import SwiftUI
import NotesComponents
import Routing

struct NotesListView: View {
    @Environment(NotesNavigationStore.self) var router
    let notes: [Note]
    let selected: NoteTag
    @Binding var searchText: String
    var body: some View {
        List {
            let filteredNotes = notes.filter { selected == .all || $0.tag == selected }
            if filteredNotes.isEmpty {
                ContentUnavailableView("No data found. Please update tag.",
                                        systemImage: "line.3.horizontal.decrease.circle")
                .background(Color(red: 15/255, green: 17/255, blue: 21/255))
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
            } else {
                ForEach(filteredNotes) { item in
                    NotesCardView(title: item.title,
                                  description: item.noteDescription,
                                  date: item.date.description,
                                  tag: item.tag.rawValue)
                    .onTapGesture {
                        router.path.append(.details)
                    }
                }
                .onDelete { indexes in
                    for index in indexes {
                      // deleteItems(notes[index])
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search notes")
        .listStyle(.plain)
        .listRowSpacing(12)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    NotesListView(notes: [.init(title: "", description: "", tag: NoteTag.ideas)],
                  selected: NoteTag.ideas,
                  searchText: .constant(""))
}
