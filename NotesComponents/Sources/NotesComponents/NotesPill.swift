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
    private var canDeselect: Bool
    
    public init(title: String, isSelected: Binding<Bool>, canDeselect: Bool = false) {
        self.title = title
        self._isSelected = isSelected
        self.canDeselect = canDeselect
    }
    
    public var body: some View {
        Button {
            if isSelected && canDeselect {
                isSelected =  false
            } else {
                isSelected = true
            }
        
            let impact = UIImpactFeedbackGenerator(style: .light)
            impact.impactOccurred()

        } label: {
            Text(title)
                .fontWeight(.medium)
                .foregroundColor(isSelected ? .white : Color.blue)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(isSelected ? Color.blue : Color(#colorLiteral(red: 0.15, green: 0.18, blue: 0.26, alpha: 1)))
                )
        }
    }
}

#Preview {
    @Previewable @State var isSelected = true
    NotesPill(title: "Work", isSelected: $isSelected)
}
