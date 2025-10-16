//
//  ContentView.swift
//  AliveGPT
//
//  Created by William Lopez on 10/3/25.
//

import SwiftUI
import PhotosUI

struct ChatView: View {
    @State private var viewModel = ChatViewModel()
    @Environment(\.dismiss) private var dismiss
    @Environment(ChatHistoryStore.self) private var chatHistoryStore
    
    var body: some View {
        NavigationStack {
            VStack {
                header.zIndex(1)
                if viewModel.messages.isEmpty {
                    aiBlobBG
                } else {
                    chat
                }
                smartMatchingButton
                    
                textField
                    .overlay(alignment: .bottom) {
                        if viewModel.showPhotoPicker {
                            CameraPickerView(selectedPhotos: $viewModel.selectedPhotos, selectedUIImages: $viewModel.selectedUIImages, selectedDocumentURLs: $viewModel.selectedDocumentURLs, onSelect: { viewModel.showPhotoPicker = false })
                                .onChange(of: viewModel.selectedPhotos) { newItems in
                                    Task {
                                        viewModel.loadedSelectedPhotos.removeAll()
                                        var loadedImages: [Image?] = []
                                        for item in newItems {
                                            loadedImages.append(try? await item.loadTransferable(type: Image.self))
                                        }
                                        
                                        viewModel.loadedSelectedPhotos = loadedImages.compactMap { $0 }
                                    }
                                }
                                .offset(x: -30, y: -95)
                        }
                    }
                    .overlay(alignment: .top) {
                        alerts
                    }
                    .animation(.snappy, value: viewModel.showErrorAlert)
                    .animation(.snappy, value: viewModel.showCreditLimitAlert)
                    .animation(.snappy, value: viewModel.showLowCreditsAlert)
                    .animation(.snappy, value: viewModel.showSuccessAlert)
                    .animation(.snappy, value: viewModel.showChatLimitAlert)
            }
            .padding(.horizontal, 15)
            .background(.aliveGPTBG)
            .sheet(isPresented: $viewModel.termsOfServiceIsPresented) {
                termsOfServiceModal.presentationDetents([.fraction(0.7)])
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
    
    @ViewBuilder
    private var alerts: some View {
        if viewModel.showChatLimitAlert {
            chatLimit
        } else if viewModel.showErrorAlert {
            ErrorAlert(
                errorMessage: viewModel.errorMessage,
                onDismiss: {
                    viewModel.showErrorAlert = false
                }
            ).offset(y: -115)
        } else if viewModel.showCreditLimitAlert {
            CreditLimitAlert(
                onPurchaseCredits: {
                    viewModel.purchaseCredits()
                },
                onUpgrade: {
                    viewModel.upgradeSubscription()
                },
                onDismiss: {
                    viewModel.showCreditLimitAlert = false
                },
                currentBalance: viewModel.creditBalance
            ).offset(y: -145)
        } else if viewModel.showLowCreditsAlert {
            LowCreditsAlert(
                onPurchaseCredits: {
                    viewModel.purchaseCredits()
                },
                onUpgrade: {
                    viewModel.upgradeSubscription()
                },
                onDismiss: {
                    viewModel.showLowCreditsAlert = false
                },
                currentBalance: viewModel.creditBalance
            ).offset(y: -125)
        } else if viewModel.showSuccessAlert {
            SuccessAlert(
                onContinue: {
                    viewModel.showSuccessAlert = false
                },
                onDismiss: {
                    viewModel.showSuccessAlert = false
                },
                currentBalance: viewModel.creditBalance
            ).offset(y: -145)
        }
    }
    
    private var smartMatchingButton: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Button(action: {
                    viewModel.requestSession()
                }) {
                    Image(.cameraSession)
                        .resizable()
                        .scaledToFit()
                    Text("Session")
                        .font(.system(.caption, weight: .light))
                        .foregroundStyle(.black)
                    Spacer()
                    Image(systemName: "arrow.right.circle")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black, .gray.opacity(0.5))
                    
                }
                .padding(8)
                .frame(height: 45)
                .background {
                    RoundedRectangle(cornerRadius: 13)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.2), radius: 1.5)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 13)
                        .stroke(.black.opacity(0.2), lineWidth: 0.6)
                }
                
                Button(action: {
                    viewModel.requestCircle()
                }) {
                    Image(.circleIcon)
                        .resizable()
                        .scaledToFit()
                    Text("Circle")
                        .font(.system(.caption, weight: .light))
                        .foregroundStyle(.black)
                    Spacer()
                    Image(systemName: "arrow.right.circle")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black, .gray.opacity(0.5))
                }
                .padding(8)
                .frame(height: 45)
                .background {
                    RoundedRectangle(cornerRadius: 13)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.2), radius: 1.5)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 13)
                        .stroke(.black.opacity(0.2), lineWidth: 0.6)
                }
                Button(action: {
                    viewModel.requestDigitalContent()
                }) {
                    Image(.digitalContent)
                        .resizable()
                        .scaledToFit()
                    Text("Digital Content")
                        .font(.system(.caption, weight: .light))
                        .foregroundStyle(.black)
                    Image(systemName: "arrow.right.circle")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black, .gray.opacity(0.5))
                }
                .padding(8)
                .frame(height: 45)
                .background {
                    RoundedRectangle(cornerRadius: 13)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.2), radius: 1.5)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 13)
                        .stroke(.black.opacity(0.2), lineWidth: 0.6)
                }
            }.buttonStyle(.plain)
        }.contentMargins(1)
    }
    
    private var header: some View {
        ZStack {
            HStack(alignment: .center) {
                Button(action: {
                    
                }) {
                    HStack(spacing: 2) {
                        Image(systemName: "chevron.left")
                        Text("Core").font(.caption)
                    }
                }
                Spacer()
                HStack(spacing: 12) {
                    NavigationLink(destination: SettingsView()) {
                        Image(.gear)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                    }
                    NavigationLink(destination: ChatHistoryView()) {
                        Image(.clockReverse)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                    }
                }
            }
            .foregroundStyle(.black)
            .padding(.vertical, 24)
            .padding(.horizontal, 15)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.aliveGPTBG)
                    .stroke(.black.opacity(0.15), lineWidth: 0.4)
                    .shadow(color: .black.opacity(0.12), radius: 1.5)
            }
            DropDownMenu(options: ChatViewModel.Membership.allCases.map(\.title), selectedOptionIndex: $viewModel.selectedOptionIndex, showDropdown: $viewModel.showDropdown)
        }
    }
    
    @ViewBuilder
    private var aiBlobBG: some View {
        Spacer()
        AIBlob()
            .padding(.bottom, 30)
        Text("AliveGPT")
            .fontWeight(.medium)
            .padding(.bottom, 2)
            .foregroundStyle(.black)
        Text("Your wellness companion")
            .fontWeight(.light)
            .font(.caption)
            .foregroundStyle(.black)
        Spacer()
    }
    
    private var chat: some View {
        ScrollView {
            ScrollViewReader { scrollViewProxy in
                VStack(spacing: 8) {
                    ForEach(viewModel.messages, id: \.id) { message in
                        MessageBubble(message: message).id(message.id)
                    }
                }
                .padding(.top, 12)
                .onChange(of: viewModel.messages) { _ in
                    // Automatically scroll to the newest message when the array changes.
                    Task { @MainActor in
                        withAnimation {
                            scrollViewProxy.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                        }
                    }
                }
                .padding(.horizontal, 5)
            }
        }
    }
    
    @ViewBuilder
    private var textField: some View {
        VStack(alignment: .leading, spacing: 8) {
            ChatInputView(viewModel: viewModel)
            ChatFooterView(viewModel: viewModel)
        }
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 13)
                .fill(.white)
                .shadow(color: .black.opacity(0.2), radius: 1.5)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 13)
                .stroke(.black.opacity(0.2), lineWidth: 0.6)
        }
    }
    
    private var termsOfServiceModal: some View {
        VStack {
            AIBlob().padding(.vertical, 35)
            Text("Alive GPT")
                .fontWeight(.medium)
                .padding(.bottom, 2)
            Text("AliveGPT is an AI chatbot and mistakes are possible, so check its responses. Responses are not intended to be relied upon as professional advice so we recommend that you consult experts for sensitive or important topics such as legal, medical, financial, or insurance-related matters. Avoid sharing confidential or personal information. You remain responsible for your content.")
                .opacity(0.6)
                .padding(.bottom, 10)
                .font(.system(.footnote, weight: .light))
            Text(viewModel.legalAttributedString)
            
            Button(action: {
                dismiss()
            }) {
                Text("Agree and say hi")
                    .foregroundStyle(.white)
                    .padding(.vertical, 18)
                    .padding(.horizontal, 35)
            }
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.purple1)
            }
            .padding(.top, 20)
            .padding(.bottom, 10)
            
            Button(action: {
                // Navigation back
            }){
                Text("Not now")
                    .opacity(0.4)
            }.buttonStyle(.plain)
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, 20)
        .background {
            LinearGradient(colors: [.purple.opacity(0.1), .purple.opacity(0.1)], startPoint: .top, endPoint: .bottom)
        }
        .ignoresSafeArea()
    }
    
    private var chatLimit: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("You have reached your chat limit")
                    .font(.system(.caption, weight: .semibold))
                Text("This chat has ended start a new chat")
                    .font(.system(.caption, weight: .light))
            }
            Spacer()
            Button(action: {
                // Start new chat
                viewModel.showChatLimitAlert = false
                viewModel.messages.removeAll()
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
        .frame(width: 300, height: 25)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
        }
    }
}

#Preview {
    NavigationStack {
        ChatView()
    }
    .environment(PreferencesManager())
    .environment(ChatHistoryStore())
}

