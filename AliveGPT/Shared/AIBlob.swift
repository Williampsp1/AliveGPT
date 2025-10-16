//
//  AIBlob.swift
//  AliveGPT
//
//  Created by William Lopez on 10/3/25.
//

import SwiftUI
import Combine

struct AIBlob: View {
    var border = true
    @State private var index: Int = 0
    @State private var index2: Int = 0
    private var images: [Image] = [Image(.aiBlob1), Image(.aiBlob2), Image(.aiBlob3), Image(.aiBlob4)]
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let timer2 = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    init(border: Bool = true) {
        self.border = border
    }
    
    var body: some View {
        ZStack {
            images[index]
                .resizable()
                .scaledToFit()
                .blur(radius: 6)
                .frame(width: 100)
                .animation(.easeInOut(duration: 0.5), value: index)
            images[index]
                .resizable()
                .scaledToFit()
                .blur(radius: 6)
                .frame(width: 100)
                .animation(.easeInOut(duration: 1), value: index)
            images[index2]
                .resizable()
                .scaledToFit()
                .blur(radius: 6)
                .frame(width: 100)
                .animation(.easeInOut(duration: 1.5), value: index2)
            images[index2]
                .resizable()
                .scaledToFit()
                .blur(radius: 6)
                .frame(width: 100)
                .animation(.easeInOut(duration: 2), value: index2)
            if border {
                Circle().stroke(Color.gray, lineWidth: 1)
                    .frame(width: 130)
            }
        }
        .onReceive(timer) { _ in
            if index == images.count - 1 {
                index = 0
            } else {
                index += 1
            }
        }
        .onReceive(timer2) { _ in
            if index2 == images.count - 1 {
                index2 = 0
            } else {
                index2 += 1
            }
        }
    }
}

#Preview {
    AIBlob(border: false)
}

