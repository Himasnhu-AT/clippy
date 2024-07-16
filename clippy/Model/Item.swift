//
//  Item.swift
//  clippy
//
//  Created by Himanshu on 7/16/24.
//

import Foundation

struct Item: Identifiable {
    
    let id = UUID()
    var value: String
    var tags: [String]
    
    init(value: String, tags: [String]) {
        self.value = value
        self.tags = tags
    }
    
    static func example() -> Item {
        Item(value: "Sample Item pasted", tags: ["password", "Email Id"])
    }
    
    static func examples() -> [Item] {
        [
            Item(value: "Sample Item pasted 1", tags: ["password", "Email Id"]),
            Item(value: "Sample Item pasted 2", tags: ["password", "Email Id"]),
            Item(value: "Sample Item pasted 3", tags: ["password", "Email Id"]),
            Item(value: "Sample Item pasted 4", tags: ["password", "Email Id"])
        ]
    }
    
}
