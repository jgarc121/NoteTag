//
//  NoteTag.swift
//  notes-app
//
//  Created by Jose Garcia on 5/17/25.
//

enum NoteTag: String, CaseIterable, Codable {
    case all = "All"
    case none = "None"
    case work = "Work"
    case personal = "Personal"
    case ideas = "Ideas"
    case tasks = "Tasks"
}
