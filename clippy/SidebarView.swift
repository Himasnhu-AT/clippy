//
//  SidebarView.swift
//  clippy
//
//  Created by Himanshu on 7/16/24.
//

import SwiftUI

struct SidebarView: View {
    
    @Binding var userCreatedGroups: [ItemGroup]
    @Binding var selection: ItemSections
    
    var body: some View {
        List(selection: $selection) {
            Section("Favourites") {
                ForEach(ItemSections.allCases) { selection in
                    Label(selection.displayName, systemImage: selection.iconName
                    ).tag(selection)
                }
            }
            
            Section("Your Groups") {
                ForEach($userCreatedGroups) { $group in
                    HStack{
                        Image(systemName: "folder")
                        TextField("New Group", text: $group.title)
                    }
                    .tag(ItemSections.list(group))
                    .contextMenu {
                        Button("Delete", role: .destructive) {
                            if let index = userCreatedGroups.firstIndex(where: { $0.id == group.id}) {
                                userCreatedGroups.remove(at: index)
                            }
                        }
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            Button(action: {
                let newGroup = ItemGroup(title: "New Group")
                userCreatedGroups.append(newGroup)
            }, label: {
                Label("Add Group", systemImage: "plus.circle")
            })
            .buttonStyle(.borderless)
            .foregroundColor(.accentColor)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .keyboardShortcut(KeyEquivalent("n"), modifiers: .command)
        }
    }
}

#Preview {
    SidebarView(userCreatedGroups: .constant(ItemGroup.examples()), selection: .constant(.all)).listStyle(.sidebar)
}
