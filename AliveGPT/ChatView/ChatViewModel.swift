//
//  ChatViewModel.swift
//  AliveGPT
//
//  Created by William Lopez on 10/12/25.
//

import Foundation
import PhotosUI
import SwiftUI

@Observable class ChatViewModel {
    var newMessageText = ""
    var termsOfServiceIsPresented: Bool = false
    var selectedOptionIndex = 0
    var showDropdown = false
    var membershipSelected: Membership {
        Membership.allCases[selectedOptionIndex]
    }
    var showPhotoPicker = false
    var showChatLimitAlert = false
    var deepResearchActive = false
    var selectedPhotos: [PhotosPickerItem] = []
    var loadedSelectedPhotos: [Image] = []
    var selectedUIImages: [UIImage] = []
    var selectedDocumentURLs: [URL] = []
    var textEditorHeight: CGFloat = 0
    var messages: [Message] = []
    var showErrorAlert = false
    var errorMessage = ""
    var showCreditLimitAlert = false
    var showLowCreditsAlert = false
    var showSuccessAlert = false
    var creditBalance = 50 // Starting balance
    let textLineHeight: CGFloat = 40
    let maxTextLines: CGFloat = 4
    let textEditorMinHeight: CGFloat = 40 // one line
    var textEditorMaxHeight: CGFloat { textLineHeight * maxTextLines }
    var chatLimit = 50
    
    var deepResearchEnabled: Bool {
        membershipSelected == .Pro || membershipSelected == .Plus || membershipSelected == .Max
    }
    
    var preferencesEnabled: Bool {
        membershipSelected == .Pro || membershipSelected == .Plus || membershipSelected == .Max
    }
    
    var legalAttributedString: AttributedString {
        var attributedString = AttributedString("By continuing, you agree to our AliveGPT Terms of Service and acknowledge that you have read our Privacy Policy")
        attributedString.font = .system(.footnote, weight: .light)
        attributedString.foregroundColor = .black.opacity(0.6)
        if let privacyRange = attributedString.range(of: "AliveGPT Terms of Service") {
            attributedString[privacyRange].link = URL(string: "https://www.google.com")
            attributedString[privacyRange].foregroundColor = .blue1
            attributedString[privacyRange].font = .system(.footnote, weight: .medium)
        }
        
        if let termsRange = attributedString.range(of: "Privacy Policy") {
            attributedString[termsRange].link = URL(string: "https://www.google.com")
            attributedString[termsRange].foregroundColor = .blue1
            attributedString[termsRange].font = .system(.footnote, weight: .medium)
        }
        
        return attributedString
    }
    
    enum Membership: String, CaseIterable, Identifiable {
        case Lite = "AliveGPT Lite"
        case Plus = "AliveGPT Plus"
        case Pro = "AliveGPT Pro"
        case Max = "AliveGPT Max"
        
        var id: String {
            self.rawValue
        }
        
        var title: String {
            self.rawValue
        }
    }
    private enum SmartMatchingType {
        case session, circle, digital
    }
    
    func imagePreviewSize(for count: Int) -> CGFloat {
        switch count {
        case 1: return 120
        case 2: return 100
        case 3: return 85
        case 4: return 70
        default: return 54
        }
    }
    
    func sendMessage() {
        guard !newMessageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        guard messages.count < chatLimit else {
            showChatLimitAlert = true
            return
        }
        
        // Check if user has enough credits
        if creditBalance <= 0 {
            showCreditLimitAlert = true
            return
        }
        
        var images: [Image] = []
        var urls: [URL] = []
        if !selectedUIImages.isEmpty {
            images = selectedUIImages.map { Image(uiImage: $0) }
        }
        if !loadedSelectedPhotos.isEmpty {
            images.append(contentsOf: loadedSelectedPhotos)
        }
        if !selectedDocumentURLs.isEmpty {
            urls.append(contentsOf: selectedDocumentURLs)
        }
        
        let newMessage = Message(text: newMessageText, images: images, urls: urls, isCurrentUser: true)
        messages.append(newMessage)
        
        // Deduct credits for user message
        deductCredits(amount: 1)
        
        // Store user message for context
        let userMessage = newMessageText
        
        // Clear the input field after sending
        newMessageText = ""
        
        selectedUIImages.removeAll()
        selectedPhotos.removeAll()
        loadedSelectedPhotos.removeAll()
        selectedDocumentURLs.removeAll()
        
        // Generate AI response after a short delay
        generateAIResponse(for: userMessage)
    }
    
    private func generateAIResponse(for userMessage: String) {
        // Simulate AI thinking time
        Task { @MainActor in
            if deepResearchActive {
                messages.append(Message(text: "AliveGPT is conducting Deep Research.....", isCurrentUser: false))
            } else {
                messages.append(Message(text: "AliveGPT is thinking...", isCurrentUser: false))
            }
            try await Task.sleep(nanoseconds: UInt64.random(in: 1_000_000_000...3_000_000_000)) // 1-3 seconds
            
            // Randomly show error or credit limit (15% chance total)
            let randomValue = Double.random(in: 0...1)
            if randomValue < 0.1 {
                messages.removeLast() // Remove thinking message
                showRandomError()
                return
            } else if randomValue < 0.15 {
                messages.removeLast() // Remove thinking message
                showCreditLimit()
                return
            }
            
            let aiResponse = getRandomAIResponse(for: userMessage)
            let aiMessage = Message(text: aiResponse, isCurrentUser: false)
            messages[messages.count - 1] = aiMessage
            
            // Deduct credits for AI response
            deductCredits(amount: 2)
        }
    }
    
    private func getRandomAIResponse(for userMessage: String) -> String {
        return MockAIResponses.getResponse(for: userMessage)
    }
    
    func removeAttachment(at index: Int) {
        guard selectedUIImages.indices.contains(index) || selectedDocumentURLs.indices.contains(index) || loadedSelectedPhotos.indices.contains(index) else { return }
        withAnimation(.spring) {
            if selectedUIImages.indices.contains(index) {
                
                selectedUIImages.remove(at: index)
            }
            if selectedDocumentURLs.indices.contains(index) {
                selectedDocumentURLs.remove(at: index)
            }
            if selectedPhotos.indices.contains(index) {
                selectedPhotos.remove(at: index)
            }
            if loadedSelectedPhotos.indices.contains(index) {
                loadedSelectedPhotos.remove(at: index)
            }
        }
    }
    
    func recalculateTextEditorHeight() {
        let textView = UITextView()
        textView.text = newMessageText.isEmpty ? "" : newMessageText
        textView.font = UIFont.systemFont(ofSize: 17) // Match your styling if needed
        let size = textView.sizeThatFits(CGSize(width: 240, height: CGFloat.greatestFiniteMagnitude))
        textEditorHeight = size.height
    }
      
    func requestSession() {
        generateSmartMatchingResponse(type: .session)
    }
    
    func requestCircle() {
        generateSmartMatchingResponse(type: .circle)
    }
    
    func requestDigitalContent() {
        generateSmartMatchingResponse(type: .digital)
    }
    
    private func generateSmartMatchingResponse(type: SmartMatchingType) {
        Task { @MainActor in
            // Show thinking message
            messages.append(Message(text: "AliveGPT is thinking...", isCurrentUser: false))
            
            // Simulate AI processing
            try await Task.sleep(nanoseconds: UInt64.random(in: 1_000_000_000...3_000_000_000)) 
            
            // Randomly show error or credit limit (20% chance total for smart matching)
            let randomValue = Double.random(in: 0...1)
            if randomValue < 0.12 {
                messages.removeLast() // Remove thinking message
                showRandomError()
                return
            } else if randomValue < 0.2 {
                messages.removeLast() // Remove thinking message
                showCreditLimit()
                return
            }
            
            // Generate the appropriate smart matching item
            let item: SmartMatchingItem
            
            switch type {
            case .session:
                item = SmartMatchingGenerator.generateLiveSession()
            case .circle:
                item = SmartMatchingGenerator.generateCircle()
            case .digital:
                item = SmartMatchingGenerator.generateDigitalContent()
            }
            
            // Create AI message with smart matching card
            let aiMessage = Message(
                text: "",
                isCurrentUser: false,
                smartMatchingItem: item
            )
            
            // Replace thinking message with actual response
            messages[messages.count - 1] = aiMessage
            
            // Deduct credits for smart matching (costs more)
            deductCredits(amount: 5)
        }
    }
 
    private func showRandomError() {
        let errors = [
            "Network connection lost. Please check your internet and try again.",
            "Service temporarily unavailable. Please try again in a moment.",
            "Unable to process request. Error code: 500",
            "Request timeout. The server took too long to respond.",
            "Invalid response from server. Please try again.",
            "Rate limit exceeded. Please wait a moment before trying again."
        ]
        
        errorMessage = errors.randomElement()!
        showErrorAlert = true
    }
    
    private func showCreditLimit() {
        showCreditLimitAlert = true
    }
    
    func purchaseCredits() {
        // Add 10 credits
        creditBalance += 10
        showCreditLimitAlert = false
        showLowCreditsAlert = false
        showSuccessAlert = true
        print("Purchased 10 credits. New balance: \(creditBalance)")
    }
    
    func upgradeSubscription() {
        showCreditLimitAlert = false
        showLowCreditsAlert = false
        showSuccessAlert = false
        print("Navigate to subscription upgrade")
    }
    
    private func deductCredits(amount: Int) {
        creditBalance -= amount
        
        // Show low credits warning when balance is low
        if creditBalance > 0 && creditBalance <= 15 && !showLowCreditsAlert {
            // Random chance to show warning (30% when credits are low)
            if Double.random(in: 0...1) < 0.3 {
                showLowCreditsAlert = true
            }
        }
    }
}
