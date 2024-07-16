//
//  MainView.swift
//  clippy
//
//  Created by Himanshu on 7/16/24.
//

import SwiftUI

struct MainView: View {
    var title: String
    var items: [Item]

    @StateObject private var clipboardMonitor = ClipboardMonitor()

    var body: some View {
        VStack {
            // HStack, give option to store as you wish too
            List {
                ForEach(items) { item in
                    Text(item.value)
                        .padding()
                        .onTapGesture {
                            clipboardMonitor.setClipboardContent(item.value)
                            pasteAtCursor()
                        }
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(title: "Sample Title", items: Item.examples())
    }
}
