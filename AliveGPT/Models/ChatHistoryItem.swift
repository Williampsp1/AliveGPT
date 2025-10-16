//
//  ChatHistoryItem.swift
//  AliveGPT
//
//  Created by William Lopez on 10/15/25.
//

import Foundation

struct ChatHistoryItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let date: Date
}


