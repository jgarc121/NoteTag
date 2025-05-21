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
}
