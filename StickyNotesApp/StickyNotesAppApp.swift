//
//  StickyNotesAppApp.swift
//  StickyNotesApp
//
//  Created by Mohamed El Damaty on 30/11/2024.
//

import SwiftUI

@main
struct StickyNoteApp: App {
    @NSApplicationDelegateAdaptor(StickyNoteAppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            EmptyView() // Prevents the default black window
        }
        .commands {
            CommandGroup(replacing: .newItem) {
                Button("Toggle Sticky Note") {
                    toggleStickyNote()
                }
                .keyboardShortcut("0", modifiers: [.command, .option]) // Command + Option + 0
            }
        }
    }

    private func toggleStickyNote() {
        guard let panel = appDelegate.panel else { return }
        if panel.isVisible {
            panel.orderOut(nil) // Hide the panel
        } else {
            panel.makeKeyAndOrderFront(nil) // Show the panel
        }
    }
}




