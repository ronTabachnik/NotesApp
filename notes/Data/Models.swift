//
//  Models.swift
//  notes
//
//  Created by Ron Tabachnik on 04/09/2024.
//

import Foundation
import CoreLocation

struct User: Codable, Identifiable, Hashable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let gender: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case gender
        case avatar
    }
}

enum Menu: CaseIterable {
    case Users
    case Notes
    case Map
    
    var text: String {
        switch self {
        case .Users:
            "Users"
        case .Notes:
            "Notes"
        case .Map:
            "Map"
        }
    }
    
    var image: String {
        switch self {
        case .Users:
            "person.3"
        case .Notes:
            "note"
        case .Map:
            "map"
        }
    }
}

struct Note: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var content: String
    var date: Date
    var image: Icon?
    var latitude: CGFloat
    var longitude: CGFloat
}

enum Icon: String, CaseIterable, Codable, Hashable {
    case person
    case star
    case heart
    case house
    case gear
    case bell
    case calendar
    case envelope
    case magnifyingglass
    case trash

    var text: String {
        switch self {
        case .person:
            return "person"
        case .star:
            return "star"
        case .heart:
            return "heart"
        case .house:
            return "house"
        case .gear:
            return "gear"
        case .bell:
            return "bell"
        case .calendar:
            return "calendar"
        case .envelope:
            return "envelope"
        case .magnifyingglass:
            return "magnifyingglass"
        case .trash:
            return "trash"
        }
    }
}

