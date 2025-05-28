//
//  AddView.swift
//  notes-app
//
//  Created by Jose Garcia on 5/4/25.
//

import NotesComponents
import SwiftUI

struct AddView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(NotesNavigationStore.self) private var router
    @State private var selected: NoteTag = .none
    @State var title: String = ""
    @State var description: String = ""
    
    var body: some View {
        VStack {
            TagSelectionView(tags: NoteTag.selectableCases, selected: $selected)
            
            VStack {
                NotesTextField(text: $title)
                NotesTextField(text: $description)
                Spacer()
            }
            .padding()
            .background(Color(red: 15/255, green: 17/255, blue: 21/255))
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Submit") {
                    addItem()
                    goBack()
                }
                .padding()
                .disabled(submitButtonIsDisabled)
            }
        }
        .padding(.top, 10)
        .background(Color(red: 15/255, green: 17/255, blue: 21/255))
    }
    
    func goBack() {
        router.path.removeLast()
    }
    
    var submitButtonIsDisabled: Bool {
        (title.isEmpty || description.isEmpty)
    }
    
    func addItem() {
        let note = Note(title: title,
                       description: description,
                       tag: selected)
        NoteManager.shared.addNote(note, in: modelContext)
    }
}

#Preview {
    AddView()
}
