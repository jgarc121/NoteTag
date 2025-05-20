//
//  NotesMainView.swift
//  notes-app
//
//  Created by Jose Garcia on 5/3/25.
//

import SwiftUI
import NotesComponents
import SwiftData

struct NotesView: View {
    let filters = NoteTag.allCases
    
    @State var searchText: String = ""
    @State var selected: NoteTag = .all
    @Environment(\.modelContext) private var modelContext
    @Query private var notes: [Note]
    @State var path: [NoteRoute] = .init()
    
    var body: some View {
        NavigationStack(path: $path) {
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
        }
    }
    
    @ViewBuilder
    func notesContentView() -> some View {
        tagSelectionView()
        notesListView()
    }
    
    @ViewBuilder
    func notesListView() -> some View {
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
                        path.append(.details)
                    }
                }
                .onDelete { indexes in
                    for index in indexes {
                        deleteItems(notes[index])
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search notes")
        .listStyle(.plain)
        .listRowSpacing(12)
        .scrollIndicators(.hidden)
    }
    
    
    @ViewBuilder
    func tagSelectionView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(filters, id: \.self) { filter in
                    // TODO: Refactor this
                    if filter != .none {
                        NotesPill(title: filter.rawValue,
                                  isSelected:
                                          Binding(
                                            get: { selected == filter },
                                                set: { isSelected in
                                                    if isSelected { selected = filter }
                                                }
                                            )
                        )
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
    
    func navigateToAddNewNote() {
        path.append(.add)
    }
    
    func deleteItems(_ item: Note) {
        modelContext.delete(item)
    }
}

#Preview {
    NotesView()
        .modelContainer(for: Note.self)
}
