//
//  NoteNavigation.swift
//  notes-app
//
//  Created by Jose Garcia on 5/17/25.
//

import SwiftUI

enum NoteRoute: Routable {
    case add
    case edit(note: Note)
}

public typealias Routable = Hashable
