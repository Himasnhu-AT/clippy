//
//  ClipboardMonitor.swift
//  clippy
//
//  Created by Himanshu on 7/15/24.
//

import Foundation
import Cocoa

class ClipboardMonitor: ObservableObject {
    private let pasteboard = NSPasteboard.general
    private var changeCount: Int
    @Published var clipboardHistory: [Item] = []

    init() {
        changeCount = pasteboard.changeCount
        loadClipboardHistory()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(checkForChanges), userInfo: nil, repeats: true)
    }

    @objc private func checkForChanges() {
        if pasteboard.changeCount != changeCount {
            changeCount = pasteboard.changeCount
            if let copiedString = pasteboard.string(forType: .string) {
                addClipboardItem(Item(value: copiedString, tags: []))
            }
        }
    }

    private func addClipboardItem(_ item: Item) {
        clipboardHistory.append(item)
        saveClipboardHistory()
    }

    private func saveClipboardHistory() {
        let defaults = UserDefaults.standard
        let historyStrings = clipboardHistory.map { $0.value }
        defaults.set(historyStrings, forKey: "clipboardHistory")
    }

    func loadClipboardHistory() {
        let defaults = UserDefaults.standard
        if let historyStrings = defaults.stringArray(forKey: "clipboardHistory") {
            clipboardHistory = historyStrings.map { Item(value: $0, tags: []) }
        }
    }

    func setClipboardContent(_ content: String) {
        pasteboard.clearContents()
        pasteboard.setString(content, forType: .string)
    }

    func checkAccessibilityPermissions() -> Bool {
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true]
        return AXIsProcessTrustedWithOptions(options)
    }
}
