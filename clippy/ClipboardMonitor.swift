//
//  ClipboardMonitor.swift
//  clippy
//
//  Created by Himanshu on 7/15/24.
//

import Foundation
import Cocoa
import Combine

class ClipboardMonitor: ObservableObject {
    private let pasteboard = NSPasteboard.general
    private var changeCount: Int
    @Published var clipboardHistory: [Item] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        changeCount = pasteboard.changeCount
        loadClipboardHistory()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(checkForChanges), userInfo: nil, repeats: true)
    }

    @objc private func checkForChanges() {
        if pasteboard.changeCount != changeCount {
            changeCount = pasteboard.changeCount
            if let copiedString = pasteboard.string(forType: .string) {
                let newItem = Item(value: copiedString, tags: [])
                addClipboardItem(newItem)
                NotificationCenter.default.post(name: .newClipboardItem, object: newItem)
            }
        }
    }

    private func addClipboardItem(_ item: Item) {
        // Remove the item if it already exists in the history
        if let existingIndex = clipboardHistory.firstIndex(where: { $0.value == item.value }) {
            clipboardHistory.remove(at: existingIndex)
        }
        // Add the new item to the top of the history
        clipboardHistory.insert(item, at: 0)
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

extension Notification.Name {
    static let newClipboardItem = Notification.Name("newClipboardItem")
}
