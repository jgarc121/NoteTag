//
//  NoteNavigation.swift
//  notes-app
//
//  Created by Jose Garcia on 5/17/25.
//

import SwiftUI

enum NoteRoute: Routable2 {
    case add
    case edit
    case details
    
    var body: some View {
        switch self {
        case .add:
            AddView()
        case .edit:
            EditView()
        case .details:
            EmptyView()
        }
    }
}

public typealias Routable2 = View & Hashable & Codable
