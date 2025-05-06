//
//  NotesMainViewModel.swift
//  notes-app
//
//  Created by Jose Garcia on 5/3/25.
//

import Foundation

@Observable
final class NotesMainViewModel {
    @ObservationIgnored  let filters = NoteTag.allCases
    
    var searchText: String = ""
    var selected: NoteTag = .all
    
}
