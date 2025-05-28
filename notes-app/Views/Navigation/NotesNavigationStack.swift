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
                .navigationBarTitleDisplayMode(.inline)
                .navigationViewStyle(.stack)
                .navigationDestination(for: NoteRoute.self) { route in
                    switch route {
                    case .add:
                        AddView()
                    case .details:
                        EmptyView() // TODO: Add details view
                    case .edit:
                        EmptyView() // TODO: Add edit view
                    }
                }
        }
        .environment(notesNavigationStore)
    }
}
