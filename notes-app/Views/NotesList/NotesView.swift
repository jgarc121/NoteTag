//
//  NotesMainView.swift
//  notes-app
//
//  Created by Jose Garcia on 5/3/25.
//

import SwiftUI
import NotesComponents
import SwiftData
import Routing
import Observation

struct NotesView: View {
    let filters = NoteTag.allCases
    
    @State var searchText: String = ""
    @State var selected: NoteTag = .all
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [
        SortDescriptor(\Note.date, order: .reverse)
    ]) private var notes: [Note]
    @Environment(NotesNavigationStore.self) private var router
    
    var body: some View {
        ZStack {
            VStack {
                if notes.isEmpty {
                    ContentUnavailableView("No data found. Please add your first note.",
                                            systemImage: "square.and.pencil")
                } else {
                    notesContentView()
                }
            }
            NotesFloatingActionButton(action: navigateToAddNewNote)
        }
        .background(Color(red: 15/255, green: 17/255, blue: 21/255))
        .searchable(text: $searchText)
    }
    
    @ViewBuilder
    func notesContentView() -> some View {
        TagSelectionView(tags: NoteTag.userSelectableTags, selected: $selected)
        NotesListView(notes: notes, selected: selected, searchText: $searchText)
    }
    
    func navigateToAddNewNote() {
        router.path.append(.add)
    }
}

#Preview {
    NotesView()
        .modelContainer(for: Note.self)
        .environment(NotesNavigationStore())
}
