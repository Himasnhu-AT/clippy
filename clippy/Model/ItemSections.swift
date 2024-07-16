//
//  ItemSections.swift
//  clippy
//
//  Created by Himanshu on 7/16/24.
//

import Foundation

enum ItemSections {
    case all
    case favourites
    case important
    case list(ItemGroup)
    
    var id: String {
        switch self {
            case .all:
                "all"
            case .favourites:
                "favourites"
            case .important:
                "important"
            case .list(let ItemGroup):
                ItemGroup.id.uuidString
        }
    }
    
    var displayName: String {
        switch self {
            case .all:
                "All"
            case .favourites:
                "Favourites"
            case .important:
                "Important"
            case .list(let ItemGroup):
                ItemGroup.title
        }
    }
    
    var iconName: String {
            switch self {
                case .all:
                    "" //icon for all
                case .favourites:
                    "star"
                case .important:
                    "" // icon for important
                case .list(_):
                    "folder"
            }
        }
        
        static var allCases: [ItemSections] {
            [.all, .favourites, .important]
        }
        
        static func == (lhs: ItemSections, rhs: ItemSections) -> Bool {
            lhs.id == rhs.id
        }
}
