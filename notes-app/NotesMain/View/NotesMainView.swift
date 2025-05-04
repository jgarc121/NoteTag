//
//  NotesMainView.swift
//  notes-app
//
//  Created by Jose Garcia on 5/3/25.
//

import SwiftUI
import NotesComponents
import SwiftData

enum NoteNavigation: Hashable {
    case noteDetails
}

enum NoteTag: String, CaseIterable, Codable {
    case all = "All"
    case none = "None"
    case work = "Work"
    case personal = "Personal"
    case ideas = "Ideas"
    case tasks = "Tasks"
}

struct NotesMainView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var notes: [Note]
    @State var searchText: String = ""
    @State var addNoteSheetIsPresented: Bool = false
    @State var title: String = ""
    @State var description: String = ""
    
    @State var path: [NoteNavigation] = .init()
    
    @State private var selected: NoteTag = .all
    let filters = NoteTag.allCases
    
    
    @State private var selectedInAddNote: NoteTag = .none


    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                VStack {
                    if notes.isEmpty {
                        ContentUnavailableView("No data found. Please add your first note.",
                                                systemImage: "square.and.pencil")
                    } else {
                        notesListView()
                        
                    }
                }
                NotesFloatingActionButton(action: showSheet)
            }
            .navigationTitle("Notes")
            .background(Color(red: 15/255, green: 17/255, blue: 21/255))
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.stack)
            .sheet(isPresented: $addNoteSheetIsPresented) {
                // refresh data
                self.title = ""
                self.description = ""
                self.selectedInAddNote = .none // TODO: this needs to be refactored
            } content: {
                addNotesView()
            }
        }
    }
    
    
    @ViewBuilder
    func notesListView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(filters, id: \.self) { filter in
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
                                .onTapGesture {
                                    selected = filter
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
        .padding(.vertical)
        
        List {
            
            if selected == .all {
                ForEach(notes) { item in
                    NotesCardView(title: item.title,
                                  description: item.noteDescription,
                                  date: item.date.description,
                                  tag: item.tag.rawValue)
                    .onTapGesture {
                        path.append(.noteDetails)
                    }
                }
                .onDelete { indexes in
                    for index in indexes {
                        deleteItems(notes[index])
                    }
                    
                }
            } else {
                ForEach(notes.filter { $0.tag == selected }) { item in
                    NotesCardView(title: item.title,
                                  description: item.noteDescription,
                                  date: item.date.description,
                                  tag: item.tag.rawValue)
                    .onTapGesture {
                        path.append(.noteDetails)
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
    func addNotesView() -> some View {
        HStack {
            Button("Cancel") {
                addNoteSheetIsPresented = false
            }
            .padding()
            Spacer()
            
            Button("Submit") {
                addItem()
                addNoteSheetIsPresented = false
                
                
            }
            .padding()
            .disabled(submitButtonIsDisabled)
        }
        .padding()
        
        ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(filters.filter { $0 != .none && $0 != .all }, id: \.self) { filter in
                            NotesPill(title: filter.rawValue,
                                      isSelected:
                                      Binding(
                                            get: { selectedInAddNote == filter },
                                            set: { isSelected in
                                                if isSelected { selectedInAddNote = filter }
                                            }
                                        )
                                    )
                            .onTapGesture {
                                selectedInAddNote = filter
                            }
                        }
                    }
                    .padding(.horizontal)
                }
        
        
        VStack {
            TextField("Enter title", text: $title)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            
            TextEditor(text: $description)
                .padding([.horizontal])
                .autocorrectionDisabled()
                .background(Color(.systemBackground))
            
            
            
            Spacer()
            
            
        }
        .interactiveDismissDisabled()
        .padding()
        .background(Color(red: 15/255, green: 17/255, blue: 21/255))
//                .navigationDestination(for: NoteNavigation.self) { _ in
//                    EmptyView()
//                }
    }
    
    var submitButtonIsDisabled: Bool {
        (title.isEmpty || description.isEmpty)
    }
    
    
    
    func showSheet() {
        addNoteSheetIsPresented = true
    }
    
    func deleteItems(_ item: Note) {
        modelContext.delete(item)
    }
    
    func addItem() {
        let item = Note(title: title,
                        description: description,
                        tag: selectedInAddNote)
        

        modelContext.insert(item)
    }
    
    
}

#Preview {
    NotesMainView()
        .modelContainer(for: Note.self)
}
