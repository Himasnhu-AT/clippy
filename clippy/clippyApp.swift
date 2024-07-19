//
//  clippyApp.swift
//  clippy
//
//  Created by Himanshu on 7/15/24.
//

import SwiftUI

@main
struct clippyApp: App {
    @StateObject private var clipboardMonitor = ClipboardMonitor()

    var body: some Scene {
            WindowGroup {
                ContentView()
                    .environmentObject(clipboardMonitor)
            }

            MenuBarExtra {
                MenuView()
                    .environmentObject(clipboardMonitor)
            } label: {
                Image(systemName: "doc.on.clipboard")
            }
            .menuBarExtraStyle(.window)
        }
}
