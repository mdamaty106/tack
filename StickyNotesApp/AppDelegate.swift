//
//  AppDelegate.swift
//  StickyNotesApp
//
//  Created by Mohamed El Damaty on 30/11/2024.
//
import Cocoa
import SwiftUI

class StickyNoteAppDelegate: NSObject, NSApplicationDelegate {
    var panel: NSPanel? // Reference to the floating sticky note panel
    var viewModel = StickyNoteViewModel() // Shared view model instance for managing note text

    func applicationDidFinishLaunching(_ notification: Notification) {
        createFloatingPanel()
    }

    private func createFloatingPanel() {
        // Create an NSPanel
        let panel = NSPanel(
            contentRect: NSRect(x: 100, y: 100, width: 400, height: 400),
            styleMask: [.nonactivatingPanel, .resizable, .titled], // Non-activating so it floats
            backing: .buffered,
            defer: true
        )
        
        // Embed SwiftUI ContentView using NSHostingController
        let hostingController = NSHostingController(
            rootView: ContentView(viewModel: viewModel) // Pass the shared view model
        )
        panel.contentView = hostingController.view
        panel.title = "Sticky Note" // Panel title

        // Configure the panel to float and persist
        configurePanelToFloat(panel)

        // Store the reference to the panel
        self.panel = panel
    }

    private func configurePanelToFloat(_ panel: NSPanel) {
        panel.isFloatingPanel = true // Makes the panel float above other windows
        panel.hidesOnDeactivate = false // Keeps the panel visible when inactive
        panel.level = .floating // Ensures the panel floats above all other windows
        panel.collectionBehavior = [.canJoinAllSpaces, .stationary, .fullScreenAuxiliary] // Persist across spaces
        panel.isMovableByWindowBackground = true // Allow dragging by clicking anywhere in the background
        panel.makeKeyAndOrderFront(nil) // Show the panel immediately
    }
}


