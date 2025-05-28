//
//  NoteManager.swift
//  notes-app
//
//  Created by Jose Garcia on 5/20/25.
//

import Foundation
import SwiftData

@MainActor
final class NoteManager {
    static let shared = NoteManager()
    
    private init() {}

    // Add a new note
    func addNote(_ note: Note, in context: ModelContext) {
        context.insert(note)
        try? context.save()
    }

    // Delete a note
    func deleteNote(_ note: Note, from context: ModelContext) {
        context.delete(note)
        try? context.save()
    }

    // Update an existing note
    func updateNote(_ note: Note, in context: ModelContext) {
        try? context.save()
    }
}
