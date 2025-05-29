//
//  NotesNavigationStack.swift
//  notes-app
//
//  Created by Jose Garcia on 5/20/25.
//

import SwiftUI
import Routing

struct NotesNavigationStack: View {
    @State var notesNavigationStore: NotesNavigationStore = .init()
    
    var body: some View {
        NavigationStack(path: $notesNavigationStore.path) {
            NotesView()
                .navigationTitle("Notes")
                .preferredColorScheme(.dark)
                .navigationBarTitleDisplayMode(.inline)
                .navigationViewStyle(.stack)
                .navigationDestination(for: NoteRoute.self) { route in
                    switch route {
                    case .add:
                        AddView()
                    case .edit(let note):
                        EditView(note: note)
                    }
                }
        }
        .environment(notesNavigationStore)
    }
}
