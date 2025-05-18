//
//  CreateView.swift
//  notes-app
//
//  Created by Jose Garcia on 5/4/25.
//

import NotesComponents
import SwiftUI

struct CreateView: View {
    @Environment(\.modelContext) private var modelContext
    let filters = NoteTag.allCases
    @State private var selected: NoteTag = .none
    @State var title: String = ""
    @State var description: String = ""
    
    var body: some View {
        VStack {
            tagPicker()
            
            VStack {
                TextField("Enter title", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                
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
        .padding(.top, 10)
        .background(Color(red: 15/255, green: 17/255, blue: 21/255))
    }
    
    
    
    @ViewBuilder
    func tagPicker() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(selectableTags, id: \.self) { filter in
                    NotesPill(title: filter.rawValue,
                              isSelected:
                                Binding(
                                    get: { selected == filter },
                                    set: { isSelected in
                                        if isSelected {
                                            selected = filter
                                        } else {
                                            selected = .none
                                        }
                                    }
                                ),
                              canDeselect: true
                    )
                }
            }
            .padding(.horizontal)
        }
    }
    
    var selectableTags: [NoteTag] {
        NoteTag.allCases.filter { $0 != .none && $0 != .all }
    }
    
    
    var submitButtonIsDisabled: Bool {
        (title.isEmpty || description.isEmpty)
    }
    
    func addItem() {
        let item = Note(title: title,
                        description: description,
                        tag: selected)
        

        modelContext.insert(item)
    }
    
}

#Preview {
    CreateView()
}
