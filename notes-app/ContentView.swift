//
//  ContentView.swift
//  notes-app
//
//  Created by Jose Garcia on 4/21/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var notes: [Note]
    @State var searchText: String = ""
    @State var addNoteSheetIsPresented: Bool = false
    @State var title: String = ""
    @State var description: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if notes.isEmpty {
                         ContentUnavailableView("No data found. Please add your first note.",
                                                systemImage: "square.and.pencil")
                    } else {
                        List {
                            ForEach(notes) { item in
                                CardView(title: item.title,
                                         description: item.noteDescription,
                                         date: item.date.description)
                            }
                            .onDelete { indexes in
                                for index in indexes {
                                    deleteItems(notes[index])
                                }
                                
                            }
                        }
                        .searchable(text: $searchText, prompt: "Search notes")
                        .listStyle(.plain)
                        .listRowSpacing(12)
                        .scrollIndicators(.hidden)
                        
                    }
                }
                FloatingActionButton(action: showSheet)
            }
            .navigationTitle("Notes")
            .background(Color(red: 15/255, green: 17/255, blue: 21/255))
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.stack)
            .sheet(isPresented: $addNoteSheetIsPresented) {
                // onDismiss
                self.title = ""
                self.description = ""
            } content: {
                HStack {
                    Button("Cancel") {
                        addNoteSheetIsPresented = false
                    }
                    .padding()
                    Spacer()
                }
                
                VStack {
                    TextField("Enter title", text: $title)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    TextEditor(text: $description)
                        .frame(height: 150)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        }
                    
                    
                    
                    Spacer()
                    
                    Button("Submit") {
                        addItem()
                        addNoteSheetIsPresented = false
                    }
                    .padding()
                }
                .interactiveDismissDisabled()
                .padding()
                .background(Color(red: 15/255, green: 17/255, blue: 21/255))
            }
        }
    }
    
    func showSheet() {
        addNoteSheetIsPresented = true
    }
    
    func deleteItems(_ item: Note) {
        modelContext.delete(item)
    }
    
    func addItem() {
        let item = Note(title: title,
                        description: description)
        
        modelContext.insert(item)
    }
    
    
}

#Preview {
    ContentView()
        .modelContainer(for: Note.self)
}


struct CardView: View {
    let title: String
    let description: String
    let date: String
    
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Tag")
                        .font(.body)
                        .foregroundColor(Color.blue)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .fill(Color(red: 32/255, green: 40/255, blue: 55/255))
                        )
                    Text(title)
                        .font(.title)
                        .padding(.bottom, 8.0)
                    Text(description)
                        .padding(.bottom, 10.0)
                    Text(date)
                        .padding(.bottom, 18.0)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 17.0)
            .padding(.top, 13.0)
            .padding(.bottom, 18.0)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(red: 0.13, green: 0.14, blue: 0.15))
            )
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        .padding(.horizontal, 16.0)
        .background(Color(red: 15/255, green: 17/255, blue: 21/255))
    }
}


@Model
class Note: Identifiable {
    
    var id: String
    var title: String
    var noteDescription: String
    var date: Date
    
    init(title: String, description: String) {
        self.id = UUID().uuidString
        self.title = title
        self.noteDescription = description
        self.date = Date()
    }
}

//private func addItem() {
//    withAnimation {
//        let newItem = Item(timestamp: Date())
//        modelContext.insert(newItem)
//    }
//}
//
//private func deleteItems(offsets: IndexSet) {
//    withAnimation {
//        for index in offsets {
//            modelContext.delete(items[index])
//        }
//    }
//}


struct FloatingActionButton: View {
    var action: () -> Void

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: action) {
                    Image(systemName: "plus")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 20)
            }
        }
    }
}
