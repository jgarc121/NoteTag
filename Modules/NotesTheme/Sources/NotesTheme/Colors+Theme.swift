//
//  Color+Theme.swift
//  NotesTheme
//
//  Created by Jose Garcia on 5/28/25.
//

import SwiftUI

extension Color {
    public static let backgroundColor = Color("BackgroundColor", bundle: .module)
    public static let primaryText = Color("PrimaryText", bundle: .module)
    public static let tagSelectedBackground = Self.blue
    public static let tagNotSelectedBackground = Color("TagNotSelectedBackground", bundle: .module)
    public static let tagSelectedText = Self.white
    public static let tagNotSelectedText = Self.blue
    public static let floatingButtonColor = Self.blue
    public static let cardBackgroundColor = Color("CardBackgroundColor", bundle: .module)
    public static let cardTextColor: Color = .white
}


