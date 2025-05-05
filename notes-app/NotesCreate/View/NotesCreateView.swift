//
//  NotesCreateView.swift
//  notes-app
//
//  Created by Jose Garcia on 5/4/25.
//

import NotesComponents
import SwiftUI

struct NotesCreateView: View {
    @Environment(\.modelContext) private var modelContext
    let filters = NoteTag.allCases
    @State private var selectedInAddNote: NoteTag = .none
    @State var title: String = ""
    @State var description: String = ""
    
    var body: some View {
        VStack {
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
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Submit") {
                    addItem()
                    // TODO: Navigate user back
                }
                .padding()
                .disabled(submitButtonIsDisabled)
            }
        }
    }
    
    
    var submitButtonIsDisabled: Bool {
        (title.isEmpty || description.isEmpty)
    }
    
    func addItem() {
        let item = Note(title: title,
                        description: description,
                        tag: selectedInAddNote)
        

        modelContext.insert(item)
    }
    
}

#Preview {
    NotesDetailsView()
}
