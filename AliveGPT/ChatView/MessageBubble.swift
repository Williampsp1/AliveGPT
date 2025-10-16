//
//  MessageBubble.swift
//  AliveGPT
//
//  Created by William Lopez on 10/12/25.
//

import SwiftUI

struct MessageBubble: View {
    let message: Message
    
    var body: some View {
        HStack {
            // Align to the right if the message is from the current user.
            if message.isCurrentUser {
                Spacer()
            }
            
            VStack(alignment: message.isCurrentUser ? .trailing : .leading) {
                if let images = message.images, !images.isEmpty {
                    ForEach(Array(images.enumerated()), id: \.offset) { idx, image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black.opacity(0.33), lineWidth: 1)
                            }
                    }
                }
                
                if !message.text.isEmpty {
                    Text(message.text)
                        .fontWeight(.light)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                        .background(message.isCurrentUser ? .userBubbleBG : .clear)
                        .foregroundColor(.black)
                        .if(message.isCurrentUser) { view in
                            view.clipShape (
                                RoundedCornersShape(radius: 20, corners: [.topLeft, .topRight, .bottomLeft])
                            )
                            .overlay {
                                RoundedCornersShape(radius: 20, corners: [.topLeft, .topRight, .bottomLeft])
                                    .stroke(.black.opacity(0.33), lineWidth: 1)
                            }
                        }
                        .frame(maxWidth: 300, alignment: message.isCurrentUser ? .trailing : .leading)
                }
                
                // Smart Matching Card
                if let item = message.smartMatchingItem {
                    SmartMatchingCard(item: item) {
                        print("View Now tapped for: \(item.title)")
                    }
                }
                
                if !message.isCurrentUser {
                    AIBlob(border: false).frame(width: 20, height: 20)
                }
            }
            // Align to the left if the message is from another user.
            if !message.isCurrentUser {
                Spacer()
            }
        }
    }
}

#Preview {
    MessageBubble(message: Message(text: "Hello, world!", isCurrentUser: true))
}
