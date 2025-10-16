//
//  SuccessAlert.swift
//  AliveGPT
//
//  Created by William Lopez on 10/16/25.
//

import SwiftUI

struct SuccessAlert: View {
    let onContinue: () -> Void
    let onDismiss: () -> Void
    let currentBalance: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Circle()
                    .fill(.green1)
                    .stroke(.black.opacity(0.33), lineWidth: 0.5)
                    .frame(width: 40, height: 40)
                    .overlay {
                        Image(systemName: "checkmark")
                            .font(.system(.footnote, weight: .bold))
                            .foregroundColor(.white)
                    }
                Spacer()
                Button(action: onDismiss) {
                    Image(systemName: "xmark")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                }
            }
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Usage updated")
                        .font(.system(.caption, weight: .semibold))
                        .foregroundColor(.black).padding(.bottom, 5)
                    
                    Text("Your purchase was successful! You can now carry on interacting with AliveGPT like before!")
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(.caption, weight: .light))
                        .foregroundColor(.black)
                }
            }.padding(.bottom, 2)
            
            Button(action: onContinue) {
                Text("continue")
                    .font(.system(.caption, weight: .medium))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.lightGreen2)
                            .stroke(.black.opacity(0.33), lineWidth: 0.5)
                            .shadow(color: .black.opacity(0.1), radius: 1)
                    )
            }.padding(.bottom, 4)
            
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
        
        SuccessAlert(
            onContinue: {},
            onDismiss: {},
            currentBalance: 19
        )
        .padding()
    }
}

