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
    @State var notesNavigationStore: NotesNavigationStore = .init()
    
    var body: some View {
        NavigationStack(path: $notesNavigationStore.path) {
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
            .navigationTitle("Notes")
            .background(Color(red: 15/255, green: 17/255, blue: 21/255))
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.stack)
            .navigationDestination(for: NoteRoute.self)
            .searchable(text: $searchText)
        }
        .environment(notesNavigationStore)
    }
    
    @ViewBuilder
    func notesContentView() -> some View {
        TagSelectionView(selected: $selected)
        NotesListView(notes: notes, selected: selected, searchText: $searchText)
    }
    
    func navigateToAddNewNote() {
        notesNavigationStore.path.append(.add)
    }
    
    func deleteItems(_ item: Note) {
        NoteManager.shared.deleteNote(item, from: modelContext)
    }
}

#Preview {
    NotesView()
        .modelContainer(for: Note.self)
}
