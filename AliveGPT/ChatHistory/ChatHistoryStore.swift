//
//  ChatHistoryStore.swift
//  AliveGPT
//
//  Created by William Lopez on 10/15/25.
//

import Foundation
import SwiftUI

@Observable class ChatHistoryStore {
    var searchText: String = ""
    var chatHistory: [ChatHistoryItem] = [
        ChatHistoryItem(title: "Summary or title of past chat", description: "Brief description of past chat, or main context", date: Date()),
        ChatHistoryItem(title: "Summary or title of past chat", description: "Brief description of past chat, or main context", date: Date()),
        ChatHistoryItem(title: "Summary or title of past chat", description: "Brief description of past chat, or main context", date: Date()),
        ChatHistoryItem(title: "Summary or title of past chat", description: "Brief description of past chat, or main context", date: Date())
    ]
    var showChatDeleteAlert = false
    var showAllChatDeleteAlert = false
    var chatToDelete: ChatHistoryItem?
    var showMaxChatsAlert = false
    var maxChatsCheck: Bool {
        maxChats == chatHistory.count
    }
    private var maxChats = 4
    
    func deleteChat(_ chat: ChatHistoryItem) {
        chatHistory.removeAll { $0.id == chat.id }
    }
    
    func deleteAll() {
        chatHistory.removeAll()
    }
}
