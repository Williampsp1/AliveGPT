//
//  ChatHistoryRow.swift
//  AliveGPT
//
//  Created by William Lopez on 10/16/25.
//

import SwiftUI

struct ChatHistoryRow: View {
    let chat: ChatHistoryItem
    let onDelete: () -> Void
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 12) {
                Text(chat.title)
                    .font(.system(.subheadline, weight: .medium))
                    .foregroundColor(.black)
                Text(chat.description)
                    .font(.system(.caption, weight: .light))
                    .foregroundStyle(.black.opacity(0.6))
                    .lineLimit(2)
            }
            
            Spacer()
            
            Button(action: onDelete) {
                Image(systemName: "xmark")
                    .font(.system(.subheadline, weight: .medium))
                    .foregroundColor(.black)
            }
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .stroke(.black.opacity(0.33), lineWidth: 0.5)
        }
    }
}

#Preview {
    ChatHistoryRow(chat: ChatHistoryItem(title: "Hello", description: "", date: Date()), onDelete: {})
}
