//
//  SmartMatchingItem.swift
//  AliveGPT
//
//  Created by William Lopez on 10/16/25.
//

import Foundation
import SwiftUI

enum ContentType {
    case liveSession
    case fixedCircle
    case ongoingCircle
    case digitalContent
    
    var displayText: String {
        switch self {
        case .liveSession: return "Live Session"
        case .fixedCircle: return "Fixed Circle"
        case .ongoingCircle: return "Ongoing circle"
        case .digitalContent: return "Digital Content"
        }
    }
    
    var badgeColor: Color {
        switch self {
        case .liveSession: return .purple8
        case .fixedCircle: return .lightOrange
        case .ongoingCircle: return .blue3
        case .digitalContent: return .blue4
        }
    }
}

enum AccessType {
    case oneOnOne
    case group
    case `public`
    
    var displayText: String {
        switch self {
        case .oneOnOne: return "One on One"
        case .group: return "Group"
        case .public: return "public"
        }
    }
    
    var icon: String {
        switch self {
        case .oneOnOne: return "one.on.one"
        case .group: return "group"
        case .public: return "unlock"
        }
    }
}

enum InstructorBadgeType: String {
    case t1 = "T1"
    case t2 = "T2"
    case t3 = "T3"
    
    var badgeColor: Color {
        switch self {
        case .t1: return .blue2
        case .t2: return .lightRed2
        case .t3: return .lightGreen
        }
    }
}

struct SmartMatchingItem: Identifiable {
    let id = UUID()
    let matchingType: String 
    let contentType: ContentType
    let accessType: AccessType?
    let liveDate: String?
    let title: String
    let instructorName: String
    let instructorBadge: InstructorBadgeType
    let rating: Double
    let reviewCount: Int
    let duration: Int?
    let attendees: String?
    let accessPeriod: String?
    let memberCount: Int?
    let boughtCount: Int?
    let description: String
    let matchPercentage: Int
    let credits: Int
    let isFavorited: Bool
}

