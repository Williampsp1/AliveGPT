//
//  ChatFooterView.swift
//  AliveGPT
//
//  Created by William Lopez on 10/12/25.
//

import SwiftUI

struct ChatFooterView: View {
    let viewModel: ChatViewModel
    @Environment(PreferencesManager.self) private var preferences: PreferencesManager
    
    var body: some View {
        NavigationStack {
            HStack(spacing: 5) {
                let areThereAttachments = !viewModel.selectedUIImages.isEmpty || !viewModel.selectedDocumentURLs.isEmpty || !viewModel.loadedSelectedPhotos.isEmpty
                let isAttachmentButtonEnabled = viewModel.selectedUIImages.count < 5 && viewModel.loadedSelectedPhotos.count < 5 && viewModel.selectedDocumentURLs.count < 5
                
                Button(action: {
                    if isAttachmentButtonEnabled {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            viewModel.showPhotoPicker.toggle()
                        }
                    }
                }) {
                    HStack(spacing: 3) {
                        Image(systemName: "paperclip")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10)
                        Text("Attach")
                            .font(.caption2)
                    }.foregroundStyle(areThereAttachments ? .white : .black)
                }
                .frame(height: 20)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(areThereAttachments ? .black : .white)
                        .stroke(.black.opacity(0.3), lineWidth: 0.6)
                }
                .disabled(viewModel.selectedUIImages.count >= 5)
                
                Button(action: {
                    viewModel.deepResearchActive.toggle()
                }) {
                    HStack(spacing: 3) {
                        Image(.boltResearch)
                            .resizable()
                            .scaledToFit()
                        Text("Deep Research")
                            .font(.caption2)
                            .foregroundStyle(.black)
                        if !viewModel.deepResearchEnabled {
                            Image(.lock)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 8)
                        }
                    }
                }
                .frame(height: 20)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(viewModel.deepResearchActive && viewModel.deepResearchEnabled ? .purple7 : .clear)
                        .stroke(.black.opacity(0.3), lineWidth: 0.6)
                }
                .allowsHitTesting(viewModel.deepResearchEnabled)
                
                NavigationLink(destination: PreferenceQuiz()) {
                    HStack(spacing: 3) {
                        Image(.stars)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10)
                        Text("Preference Quiz")
                            .font(.caption2)
                            .foregroundStyle(.black)
                        if !viewModel.preferencesEnabled {
                            Image(.lock)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 8)
                        }
                    }
                    .frame(height: 20)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(preferences.preferencesSaved && viewModel.preferencesEnabled ? .purple7 : .clear)
                            .stroke(.black.opacity(0.3), lineWidth: 0.6)
                    }
                }
                .allowsHitTesting(viewModel.preferencesEnabled)
                
                Button(action: viewModel.sendMessage) {
                    Text("send")
                        .font(.caption2)
                        .foregroundStyle(viewModel.newMessageText.isEmpty && !areThereAttachments ? .black : .white)
                        .frame(height: 20)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(viewModel.newMessageText.isEmpty && !areThereAttachments ? .white : .black)
                        }
                        .shadow(color: .black.opacity(0.3), radius: 1)
                }.disabled(viewModel.showChatLimitAlert ? true : false)
            }
            .minimumScaleFactor(0.8)
            .lineLimit(1)
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    ChatFooterView(viewModel: ChatViewModel()).environment(PreferencesManager())
}
