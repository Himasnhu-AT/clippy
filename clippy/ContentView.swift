//
//  ContentView.swift
//  clippy
//
//  Created by Himanshu on 7/15/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var selection: ItemSections = .all
    @State private var allItems: [Item] = Item.examples()
    @State private var userCreatedGroups: [ItemGroup] = ItemGroup.examples()
    @StateObject private var clipboardMonitor = ClipboardMonitor()
    
    @State private var cancellables = Set<AnyCancellable>()

    var body: some View {
        NavigationSplitView(sidebar: {
            SidebarView(userCreatedGroups: $userCreatedGroups, selection: $selection)
        }, detail: {
            switch selection {
            case .all:
                MainView(title: "All", items: allItems)
            case .favourites:
                MainView(title: "Favourites", items: allItems.filter { $0.tags.contains("favourite") })
            case .important:
                MainView(title: "Important", items: allItems.filter { $0.tags.contains("important") })
            case .list(let itemGroup):
                MainView(title: itemGroup.title, items: itemGroup.items)
            }
        })
        .onAppear {
            NotificationCenter.default.publisher(for: .newClipboardItem)
                .compactMap { $0.object as? Item }
                .sink { newItem in
                    allItems.append(newItem)
                }
                .store(in: &cancellables)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ClipboardMonitor())
    }
}
