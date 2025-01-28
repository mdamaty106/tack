//
//  ContentView.swift
//  StickyNotesApp
//
//  Created by Mohamed El Damaty on 30/11/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: StickyNoteViewModel // Shared view model
    @State private var noteColor: Color = .yellow // Sticky note background color
    @State private var fontSize: CGFloat = 16 // Font size for text
    @FocusState private var isTextEditorFocused: Bool // Focus state for the TextEditor

    var body: some View {
        ZStack {
            // Sticky note background
            noteColor
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 10) {
                // Close button
                HStack {
                    Button(action: { exitStickyNote() }) {
                        Text("X")
                            .font(.system(size: 14, weight: .bold)) // Smaller font size
                            .foregroundColor(.black.opacity(0.5)) // Slightly transparent
                            .padding(5)
                    }
                    .buttonStyle(PlainButtonStyle()) // Minimal button style
                    Spacer()
                }
                .padding(.horizontal)
                .frame(height: 22) // Adjust frame to replace the title bar

                Spacer()

                // TextEditor for note content
                TextEditor(text: $viewModel.noteText)
                    .font(.system(size: fontSize))
                    .foregroundColor(.black)
                    .background(noteColor)
                    .scrollContentBackground(.hidden)
                    .padding()
                    .focused($isTextEditorFocused) // Attach focus state

                Spacer()

                // Font size and background color buttons
                HStack(spacing: 20) {
                    // Font size adjustment
                    Button(action: { fontSize += 2 }) {
                        Text("+")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black.opacity(0.7))
                    }
                    Button(action: { fontSize = max(10, fontSize - 2) }) {
                        Text("-")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black.opacity(0.7))
                    }

                    // Background color buttons
                    HStack(spacing: 10) {
                        Button(action: { noteColor = .yellow }) {
                            Circle()
                                .fill(Color.yellow)
                                .frame(width: 20, height: 20)
                        }
                        Button(action: { noteColor = .white }) {
                            Circle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 20, height: 20)
                        }
                        Button(action: { noteColor = .gray }) {
                            Circle()
                                .fill(Color.gray)
                                .frame(width: 20, height: 20)
                        }
                    }
                }
                .padding(.bottom, 5)

                // Shortcut instruction
                Text("Cmd + Opt + 0 to toggle")
                    .font(.system(size: 12))
                    .foregroundColor(.black.opacity(0.6))
                    .padding(.bottom, 10)
            }
            .padding()
        }
        .onAppear {
            isTextEditorFocused = true // Focus the TextEditor when the window appears
            hideTitleBarButtons() // Hide macOS title bar buttons
        }
        .onDisappear {
            isTextEditorFocused = false // Detach focus when the window disappears
        }
    }

    private func exitStickyNote() {
        NSApp.keyWindow?.orderOut(nil) // Hides the sticky note window
    }

    private func hideTitleBarButtons() {
        // Access the current window and hide its title bar buttons
        if let window = NSApp.keyWindow {
            window.titleVisibility = .hidden
            window.titlebarAppearsTransparent = true
            window.standardWindowButton(.closeButton)?.isHidden = true
            window.standardWindowButton(.miniaturizeButton)?.isHidden = true
            window.standardWindowButton(.zoomButton)?.isHidden = true
        }
    }
}






