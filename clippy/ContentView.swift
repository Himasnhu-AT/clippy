//
//  ContentView.swift
//  clippy
//
//  Created by Himanshu on 7/15/24.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var clipboardMonitor = ClipboardMonitor()

    var body: some View {
        VStack {
            List(clipboardMonitor.clipboardHistory, id: \.0) { item in
                Text(item.0)
                    .padding()
                    .onTapGesture {
                        clipboardMonitor.setClipboardContent(item.0)
                        pasteAtCursor()
                    }
            }
            Button("Clear History") {
                clipboardMonitor.clipboardHistory.removeAll()
                UserDefaults.standard.removeObject(forKey: "clipboardHistory")
            }
        }
        .padding()
        .onAppear {
            clipboardMonitor.loadClipboardHistory()
            if !clipboardMonitor.checkAccessibilityPermissions() {
                // Inform the user to grant accessibility permissions
                print("Please enable accessibility permissions in System Preferences.")
            }
        }
    }

    private func pasteAtCursor() {
        let source = CGEventSource(stateID: .combinedSessionState)
        let keyVDown = CGEvent(keyboardEventSource: source, virtualKey: 9, keyDown: true)
        let keyVUp = CGEvent(keyboardEventSource: source, virtualKey: 9, keyDown: false)

        keyVDown?.flags = .maskCommand
        keyVUp?.flags = .maskCommand

        keyVDown?.post(tap: .cghidEventTap)
        keyVUp?.post(tap: .cghidEventTap)
    }
}

#Preview {
    ContentView()
}
