//
//  NoteTag.swift
//  notes-app
//
//  Created by Jose Garcia on 5/17/25.
//

enum NoteTag: String, CaseIterable, Codable, Identifiable {
    case all = "All"
    case none = "None"
    case work = "Work"
    case personal = "Personal"
    case ideas = "Ideas"
    case tasks = "Tasks"
    
    var id: String { rawValue }
    
    static var selectableCases: [NoteTag] {
        allCases.filter { $0 != .none && $0 != .all }
    }
    
    static var userSelectableTags: [NoteTag] {
        allCases.filter { $0 != .none }
    }
}
