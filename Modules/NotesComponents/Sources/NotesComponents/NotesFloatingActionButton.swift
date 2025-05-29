//
//  NotesFloatingActionButton.swift
//  NotesComponents
//
//  Created by Jose Garcia on 5/3/25.
//

import SwiftUI
import NotesTheme

public struct NotesFloatingActionButton: View {
    private var action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }

    public var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: action) {
                    Image(systemName: "plus")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.floatingButtonColor)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 20)
            }
        }
    }
}


#Preview {
    NotesFloatingActionButton(action: {})
}
