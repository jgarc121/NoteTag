//
//  NotesNavigationStore.swift
//  notes-app
//
//  Created by Jose Garcia on 5/20/25.
//

import Observation

@Observable
final class NotesNavigationStore {
    var path: [NoteRoute] = .init()
    
    func goBack() {
        if path.count > 0 {
            path.removeLast()
        }
    }
}
