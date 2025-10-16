//
//  Message.swift
//  AliveGPT
//
//  Created by William Lopez on 10/12/25.
//

import Foundation
import SwiftUI

struct Message: Identifiable, Equatable {
    let id = UUID()
    let text: String
    var images: [Image]?
    var urls: [URL]?
    let isCurrentUser: Bool
    var smartMatchingItem: SmartMatchingItem?
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }
}
