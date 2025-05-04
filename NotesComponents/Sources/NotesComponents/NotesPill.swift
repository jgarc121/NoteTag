//
//  NotesPill.swift
//  NotesComponents
//
//  Created by Jose Garcia on 5/3/25.
//


import SwiftUI

public struct NotesPill: View {
    private let title: String
    @Binding var isSelected: Bool
    
    public init(title: String, isSelected: Binding<Bool>) {
        self.title = title
        self._isSelected = isSelected
    }
    
    public var body: some View {
        Text(title)
            .fontWeight(.medium)
            .foregroundColor(isSelected ? .white : Color.blue)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(isSelected ? Color.blue : Color(#colorLiteral(red: 0.15, green: 0.18, blue: 0.26, alpha: 1)))
            )
//            .onTapGesture {
//                if selected == filter {
//                    selected = "NONE"
//                } else {
//                    selected = filter
//                }
//            }
    }
}

#Preview {
    @Previewable @State var isSelected = true
    NotesPill(title: "Work", isSelected: $isSelected)
}
