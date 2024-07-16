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
        NavigationSplitView(sidebar: {
            SidebarView()
        }, detail: {
            MainView()
        })
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
