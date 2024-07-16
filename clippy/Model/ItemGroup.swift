//
//  ItemGroup.swift
//  clippy
//
//  Created by Himanshu on 7/16/24.
//

import Foundation

struct ItemGroup: Identifiable, Hashable {
    
    let id = UUID()
    var title: String
    var items: [Item]
    
    init(title: String, items: [Item] = []) {
        self.title = title
        self.items = items
    }
    
    static func example() -> ItemGroup {
        let item = Item.examples()
        
        let itemGroup = ItemGroup(title: "Sample 1", items: item)
        
        return itemGroup
    }
    
    static func examples() -> [ItemGroup] {
        let itemGroup1 = ItemGroup.example()
        let itemGroup2 = ItemGroup(title: "empty")
        
        return [itemGroup1, itemGroup2]
    }
}
