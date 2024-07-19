//
//  MenuBar.swift
//  clippy
//
//  Created by Himanshu on 7/19/24.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var clipboardMonitor: ClipboardMonitor

    var body: some View {
        VStack {
            ForEach(clipboardMonitor.clipboardHistory) { item in
                Text(item.value)
                    .padding()
                    .onTapGesture {
                        clipboardMonitor.setClipboardContent(item.value)
                        pasteAtCursor()
                    }
            }
            Divider()
            Button("Clear History") {
                clipboardMonitor.clipboardHistory.removeAll()
                UserDefaults.standard.removeObject(forKey: "clipboardHistory")
            }
        }
        .padding()
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

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environmentObject(ClipboardMonitor())
    }
}
