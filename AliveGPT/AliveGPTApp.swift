//
//  AliveGPTApp.swift
//  AliveGPT
//
//  Created by William Lopez on 10/3/25.
//

import SwiftUI

@main
struct AliveGPTApp: App {
    @State private var chatHistoryStore = ChatHistoryStore()
    @State private var preferencesManager = PreferencesManager()
    
    var body: some Scene {
        WindowGroup {
            ChatView()
                .environment(chatHistoryStore)
                .environment(preferencesManager)
        }
    }
}
