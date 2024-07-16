//
//  ItemSections.swift
//  clippy
//
//  Created by Himanshu on 7/16/24.
//

import Foundation

enum ItemSections: Identifiable, CaseIterable, Hashable {
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
                    "tray.full"
                case .favourites:
                    "star"
                case .important:
                    "exclamationmark.circle"
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
