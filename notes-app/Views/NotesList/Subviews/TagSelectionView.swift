//
//  TagSelectionView.swift
//  notes-app
//
//  Created by Jose Garcia on 5/20/25.
//

import SwiftUI
import NotesComponents

struct TagSelectionView: View {
    @Binding var selected: NoteTag
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(NoteTag.allCases.filter { $0 != .none }, id: \.self) { filter in
                    // TODO: Refactor this
                    if filter != .none {
                        NotesPill(title: filter.rawValue,
                                  isSelected:
                                          Binding(
                                            get: { selected == filter },
                                                set: { isSelected in
                                                    if isSelected { selected = filter }
                                                }
                                            )
                        )
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
}

#Preview {
    TagSelectionView(selected: .constant(NoteTag.ideas))
}
