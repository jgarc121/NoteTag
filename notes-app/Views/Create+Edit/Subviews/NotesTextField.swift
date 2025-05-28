//
//  NotesTextField.swift
//  notes-app
//
//  Created by Jose Garcia on 5/27/25.
//

import SwiftUI

struct NotesTextField: View {
    @Binding var text: String
    
    var body: some View {
        TextField("Enter title", text: $text)
            .textFieldStyle(.roundedBorder)
            .padding(.bottom)
            .autocorrectionDisabled()
    }
}

#Preview {
    NotesTextField(text: .constant("Title"))
}
