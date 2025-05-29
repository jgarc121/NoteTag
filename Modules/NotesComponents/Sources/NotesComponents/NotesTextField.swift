//
//  NotesTextField.swift
//  notes-app
//
//  Created by Jose Garcia on 5/27/25.
//

import SwiftUI

public struct NotesTextField: View {
    @Binding var text: String
    
    public init(text: Binding<String>) {
        self._text = text
    }
    
    public var body: some View {
        TextField("Enter title", text: $text)
            .textFieldStyle(.roundedBorder)
            .padding(.bottom)
            .autocorrectionDisabled()
    }
}

#Preview {
    NotesTextField(text: .constant("Title"))
}
