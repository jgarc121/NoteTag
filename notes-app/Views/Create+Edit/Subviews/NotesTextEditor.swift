//
//  NotesTextEditor.swift
//  notes-app
//
//  Created by Jose Garcia on 5/27/25.
//

import SwiftUI

struct NotesTextEditor: View {
    @Binding var text: String
    
    var body: some View {
        TextEditor(text: $text)
            .padding([.horizontal])
            .autocorrectionDisabled()
            .background(Color(.systemBackground))
    }
}

#Preview {
    NotesTextEditor(text: .constant("Description"))
}
