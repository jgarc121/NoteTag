//
//  NotesListView.swift
//  notes-app
//
//  Created by Jose Garcia on 5/20/25.
//

import SwiftUI
import NotesComponents
import NotesTheme

struct NotesListView: View {
    @Environment(NotesNavigationStore.self) var router
    @Environment(\.modelContext) private var modelContext
    let notes: [Note]
    let selected: NoteTag
    @Binding var searchText: String
    
    var filteredNotes: [Note] {
        notes.filter { note in
            let searchMatch = searchText.isEmpty ||
                note.title.localizedCaseInsensitiveContains(searchText) ||
                note.noteDescription.localizedCaseInsensitiveContains(searchText)
            let tagMatch = selected == .all || note.tag == selected
            return searchMatch && tagMatch
        }
    }
    
    var body: some View {
        List {
            if filteredNotes.isEmpty {
                ContentUnavailableView("No data found. Please update tag.",
                                        systemImage: "line.3.horizontal.decrease.circle")
                .background(Color.backgroundColor)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
            } else {
                ForEach(filteredNotes) { item in
                    NotesCardView(title: item.title,
                                  description: item.noteDescription,
                                  date: item.date.description,
                                  tag: item.tag.rawValue)
                    .onTapGesture {
                        goToNote(item)
                    }
                }
                .onDelete { indexes in
                    for index in indexes {
                        deleteNote(index: index)
                    }
                }
            }
        }
        .listStyle(.plain)
        .listRowSpacing(12)
        .scrollIndicators(.hidden)
    }
    
    func deleteNote(index: Int) {
        NoteManager.shared.deleteNote(filteredNotes[index], from: modelContext)
    }
    
    func goToNote(_ note: Note) {
        router.path.append(.edit(note: note))
    }
    
}

#Preview {
    NotesListView(notes: [.init(title: "", description: "", tag: NoteTag.ideas)],
                  selected: NoteTag.ideas,
                  searchText: .constant(""))
}
