//
//  ErrorAlert.swift
//  AliveGPT
//
//  Created by William Lopez on 10/16/25.
//

import SwiftUI

struct ErrorAlert: View {
    let errorMessage: String
    let onDismiss: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: onDismiss) {
                    Image(systemName: "xmark")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                }
            }.padding(.top, 8)
            
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 48))
                .foregroundColor(.red)
                .padding(.bottom, 8)
            Text("An error occurred")
                .font(.system(.subheadline, weight: .semibold))
                .foregroundColor(.black)
            Text(errorMessage)
                .fixedSize(horizontal: false, vertical: true)
                .font(.system(.caption, weight: .light))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .stroke(.lightRed, lineWidth: 1)
        }
    }
}

#Preview {
    ZStack {
        Color.black.opacity(0.3)
            .ignoresSafeArea()
        
        ErrorAlert(
            errorMessage: "Outline error here with code",
            onDismiss: {}
        )
        .padding()
    }
}

