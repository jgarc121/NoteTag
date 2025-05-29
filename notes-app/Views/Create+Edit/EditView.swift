//
//  EditView.swift
//  notes-app
//
//  Created by Jose Garcia on 5/17/25.
//

import NotesComponents
import NotesTheme
import SwiftUI
import SwiftData

struct EditView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(NotesNavigationStore.self) private var router
    @State private var selected: NoteTag
    @State var title: String
    @State var description: String
    let note: Note
    
    init(note: Note) {
        self.note = note
        _title = State(initialValue: note.title)
        _description = State(initialValue: note.noteDescription)
        _selected = State(initialValue: note.tag)
    }
    
    var body: some View {
        VStack {
            TagSelectionView(tags: NoteTag.selectableCases, selected: $selected)
            
            VStack {
                NotesTextField(text: $title)
                NotesTextEditor(text: $description)
                Spacer()
            }
            .padding()
            .background(Color.backgroundColor)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Update") {
                    updateItem()
                    goBack()
                }
                .padding()
                .disabled(submitButtonIsDisabled)
            }
        }
        .padding(.top, 10)
        .background(Color.backgroundColor)
    }
    
    func goBack() {
        router.path.removeLast()
    }
    
    var submitButtonIsDisabled: Bool {
        (title.isEmpty || description.isEmpty)
    }
    
    func updateItem() {
        note.title = title
        note.noteDescription = description
        note.tag = selected
        NoteManager.shared.updateNote(note, in: modelContext)
    }
}
