//
//  ChatHistoryView.swift
//  AliveGPT
//
//  Created by William Lopez on 10/15/25.
//

import SwiftUI

struct ChatHistoryView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(ChatHistoryStore.self) private var chatHistoryStore
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                header.padding(.bottom, 18)
                searchBar
                chatHistory
                
                Button(action: {
                    chatHistoryStore.showAllChatDeleteAlert = true
                }) {
                    Text("Delete full chat history")
                        .font(.system(.caption, weight: .medium))
                        .foregroundColor(.red)
                }
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 15)
            .background(.aliveGPTBG)
            .blur(radius: chatHistoryStore.showChatDeleteAlert ? 5 : 0)
            .overlay {
                if chatHistoryStore.showChatDeleteAlert {
                    deleteChatAlert.padding(.horizontal, 15)
                } else if chatHistoryStore.showAllChatDeleteAlert {
                    deleteAllChatAlert.padding(.horizontal, 15)
                }
            }
            .animation(.snappy, value: chatHistoryStore.showChatDeleteAlert)
        }.navigationBarBackButtonHidden()
    }
    
    var chatHistory: some View {
        ScrollView {
            VStack(spacing: 20) {
                if chatHistoryStore.chatHistory.isEmpty {
                    Text("No chat history")
                        .font(.system(.caption, weight: .light))
                        .foregroundStyle(.black.opacity(0.6))
                }
                ForEach(chatHistoryStore.chatHistory) { chat in
                    ChatHistoryRow(
                        chat: chat,
                        onDelete: {
                            chatHistoryStore.showChatDeleteAlert = true
                            chatHistoryStore.chatToDelete = chat
                        }
                    )
                }
            }
        }.contentMargins(1)
    }
    
    var searchBar: some View {
        HStack {
            @Bindable var chatHistoryStore = chatHistoryStore
            Image(systemName: "magnifyingglass")
                .font(.caption)
                .foregroundColor(.gray)
            ZStack(alignment: .leading) {
                TextField("", text: $chatHistoryStore.searchText)
                    .font(.system(.caption, weight: .light))
                    .foregroundStyle(.black)
                if chatHistoryStore.searchText.isEmpty {
                        Text("search for past chats here...")
                        .font(.caption2)
                            .foregroundColor(.gray)
                    }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .stroke(.black.opacity(0.33), lineWidth: 0.5)
        }
        .padding(.top, 12)
        .padding(.bottom, 16)
        .overlay(alignment: .trailing) {
            if chatHistoryStore.showMaxChatsAlert {
                maxChatAlert
            }
        }
        .animation(.snappy, value: chatHistoryStore.showMaxChatsAlert)
    }
    
    var header: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                    Text("AliveGPT").font(.caption)
                }.foregroundColor(.black)
            }
            Spacer()
            Button(action: {
                if chatHistoryStore.maxChatsCheck {
                    chatHistoryStore.showMaxChatsAlert = true
                } else {
                    dismiss()
                }
            }) {
                HStack(spacing: 2) {
                    Image(systemName: "pencil").bold()
                    Text("New Chat")
                }
                .font(.caption2)
                .foregroundColor(.black)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 3)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.black.opacity(0.33), lineWidth: 0.5)
                    .shadow(color: .black.opacity(0.35), radius: 1)
            }
            
        }
        .overlay {
            Text("History")
                .font(.system(.title3, weight: .bold))
                .foregroundStyle(.black)
        }
    }
    
    var maxChatAlert: some View {
        HStack {
            VStack {
                Text("Delete a chat before creating a new one...")
                    .font(.system(.caption, weight: .bold))
                Text("upgrade to be able to start more chats")
                    .font(.system(.caption, weight: .regular))
            }
            Button(action: {
                chatHistoryStore.showMaxChatsAlert = false
            }) {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .lightRed2)
                    .padding(0.5)
                    .background {
                        Circle()
                            .fill(LinearGradient(colors: [.white.opacity(0.6), .white.opacity(0.1)], startPoint: .top, endPoint: .bottom))
                            .shadow(color: .black, radius: 1, y: 1)
                    }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background {
            RoundedRectangle(cornerRadius: 28)
                .fill(.lightRed)
        }
        .offset(y: -2)
    }
    
    var deleteAllChatAlert: some View {
        VStack {
            Text("Delete Entire chat history?")
                .font(.system(.subheadline, weight: .medium))
                .foregroundStyle(.black)
                .padding(.bottom, 2)
            Text("Are you sure you want to delete your full chat\nhistory? This action cannot be undone")
                .font(.system(.caption, weight: .light))
                .foregroundStyle(.black.opacity(0.6))
                .multilineTextAlignment(.center)
                .padding(.bottom, 25)
            Button(action: {
                chatHistoryStore.deleteAll()
                chatHistoryStore.showAllChatDeleteAlert = false
            }) {
                Text("Delete entire chat history")
                    .foregroundStyle(.white)
                    .font(.system(.subheadline, weight: .medium))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.black)
                    }
            }.padding(.bottom, 6)
            Button(action: {
                chatHistoryStore.showAllChatDeleteAlert = false
            }) {
                Text("Cancel")
                    .foregroundStyle(.black)
                    .font(.system(.subheadline, weight: .medium))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.purple6, lineWidth: 1)
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 50, leading: 15, bottom: 15, trailing: 15))
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.offWhite)
                .stroke(.black.opacity(0.33), lineWidth: 0.5)
                .shadow(color: .black.opacity(0.15), radius: 1)
        }
    }
    
    var deleteChatAlert: some View {
        VStack {
            Text("Delete Chat")
                .font(.system(.subheadline, weight: .medium))
                .foregroundStyle(.black)
                .padding(.bottom, 2)
            Text("Are you sure you want to delete this chat? This\naction cannot be undone")
                .font(.system(.caption, weight: .light))
                .foregroundStyle(.black.opacity(0.6))
                .multilineTextAlignment(.center)
                .padding(.bottom, 25)
            Button(action: {
                if let chat = chatHistoryStore.chatToDelete {
                    chatHistoryStore.deleteChat(chat)
                }
                chatHistoryStore.chatToDelete = nil
                chatHistoryStore.showChatDeleteAlert = false
            }) {
                Text("Delete Chat")
                    .foregroundStyle(.white)
                    .font(.system(.subheadline, weight: .medium))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.black)
                    }
            }
            .padding(.bottom, 6)
            Button(action: {
                chatHistoryStore.showChatDeleteAlert = false
            }) {
                Text("Cancel")
                    .foregroundStyle(.black)
                    .font(.system(.subheadline, weight: .medium))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.purple6, lineWidth: 1)
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 50, leading: 15, bottom: 15, trailing: 15))
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.offWhite)
                .stroke(.black.opacity(0.33), lineWidth: 0.5)
                .shadow(color: .black.opacity(0.15), radius: 1)
        }
    }
}

#Preview {
    ChatHistoryView().environment(ChatHistoryStore())
}

