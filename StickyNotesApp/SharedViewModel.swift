//
//  SharedViewModel.swift
//  StickyNotesApp
//
//  Created by Mohamed El Damaty on 30/11/2024.
//

import SwiftUI

class StickyNoteViewModel: ObservableObject {
    @Published var noteText: String = "" // The text for the sticky note
}
