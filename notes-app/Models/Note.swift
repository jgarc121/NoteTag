//
//  Note.swift
//  notes-app
//
//  Created by Jose Garcia on 5/3/25.
//

import SwiftData
import SwiftUI

@Model
class Note: Identifiable {
    var id: String
    var title: String
    var noteDescription: String
    var date: Date
    @Relationship var tag = NoteTag.none

    
    init(title: String, description: String, tag: NoteTag = .none) {
        self.id = UUID().uuidString
        self.title = title
        self.noteDescription = description
        self.date = Date()
        self.tag = tag
    }
}
