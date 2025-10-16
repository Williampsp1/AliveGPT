//
//  LowCreditsAlert.swift
//  AliveGPT
//
//  Created by William Lopez on 10/16/25.
//

import SwiftUI

struct LowCreditsAlert: View {
    let onPurchaseCredits: () -> Void
    let onUpgrade: () -> Void
    let onDismiss: () -> Void
    let currentBalance: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Circle()
                    .fill(.orange)
                    .stroke(.black.opacity(0.33), lineWidth: 0.5)
                    .frame(width: 40, height: 40)
                    .overlay {
                        Text("!")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                    }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("You're almost out of credits!")
                            .font(.system(.subheadline, weight: .semibold))
                            .foregroundColor(.black)
                        Spacer()
                        Button(action: onDismiss) {
                            Image(systemName: "xmark")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                    }.padding(.bottom, 2)
                    
                    Text("To continue talking to AliveGPT increase your usage for this chat with 10 credits or upgrade your subscription for more usage & a more advanced AI")
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(.caption, weight: .light))
                        .foregroundColor(.black)
                }
            }.padding(.bottom, 6)
            
            HStack {
                Button(action: onPurchaseCredits) {
                    HStack(spacing: 6) {
                        Image(.token)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text("10 Credits")
                            .font(.system(.caption, weight: .medium))
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.lightRed3)
                            .stroke(.black.opacity(0.33), lineWidth: 0.5)
                            .shadow(color: .black.opacity(0.1), radius: 1)
                    )
                }
                
                Button(action: onUpgrade) {
                    Text("Upgrade Subscription")
                        .font(.system(.caption, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .frame(height: 30)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.purple2)
                                .stroke(.black.opacity(0.33), lineWidth: 0.5)
                                .shadow(color: .black.opacity(0.1), radius: 1)
                        )
                }
            }.padding(.bottom, 6)
            
            HStack(spacing: 4) {
                Text("Your balance:")
                    .font(.system(.caption, weight: .light))
                    .foregroundColor(.black.opacity(0.6))
                Text("\(currentBalance) credits")
                    .font(.system(.caption, weight: .medium))
                    .foregroundColor(.black)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .stroke(.black.opacity(0.2), lineWidth: 1)
        }
    }
}

#Preview {
    ZStack {
        Color.aliveGPTBG
            .ignoresSafeArea()
        
        LowCreditsAlert(
            onPurchaseCredits: {},
            onUpgrade: {},
            onDismiss: {},
            currentBalance: 9
        )
        .padding()
    }
}

