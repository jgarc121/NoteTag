//
//  NotesPill.swift
//  NotesComponents
//
//  Created by Jose Garcia on 5/3/25.
//

import SwiftUI
import NotesTheme

public struct NotesPill: View {
    private let title: String
    @Binding var isSelected: Bool
    private var canDeselect: Bool
    
    public init(title: String, isSelected: Binding<Bool>, canDeselect: Bool = false) {
        self.title = title
        self._isSelected = isSelected
        self.canDeselect = canDeselect
    }
    // TODO: Need to refactor this pill to allow also to be used in the card itself which will not be tapable, just a view
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
                .foregroundColor(isSelected ? Color.tagSelectedText : Color.tagNotSelectedText)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(isSelected ? Color.tagSelectedBackground : Color.tagNotSelectedBackground)
                )
        }
    }
}

#Preview {
    @Previewable @State var isSelected = true
    NotesPill(title: "Work", isSelected: $isSelected)
}
