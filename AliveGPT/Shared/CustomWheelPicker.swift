//
//  CustomWheelPicker.swift
//  AliveGPT
//
//  Created by William Lopez on 10/13/25.
//

import SwiftUI

struct CustomWheelPicker: View {
    let options: [String]
    @Binding var selectedIndex: Int?
    
    private let itemHeight: CGFloat = 35
    private let menuHeightMultiplier: CGFloat = 7
    
    var body: some View {
        let visibleItems = Int(menuHeightMultiplier)
        let paddingItems = CGFloat(visibleItems / 2)
        
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ForEach(0..<options.count, id: \.self) { index in
                    let option = options[index]
                    Text(option)
                        .bold(index == selectedIndex)
                        .fontWeight(index == selectedIndex ? .bold : .light)
                        .foregroundStyle(index == selectedIndex ? .black : .gray)
                        .frame(maxWidth: .infinity)
                        .frame(height: itemHeight)
                        .id(index)
                }
            }.scrollTargetLayout()
        }
        .safeAreaPadding(.vertical, itemHeight * paddingItems)
        .scrollPosition(id: $selectedIndex, anchor: .center)
        .scrollTargetBehavior(.viewAligned)
        .frame(height: itemHeight * menuHeightMultiplier)
        .background(alignment: .center) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.purple2)
                .stroke(.black.opacity(0.33), lineWidth: 0.5)
                .frame(height: itemHeight)
        }
        .scrollIndicators(.hidden)
        .onChange(of: selectedIndex, initial: false) { oldValue, newValue in
            if newValue != nil {
                let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                impactFeedback.impactOccurred()
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var showLanguagePicker = true
        @State private var selectedLanguage = PreferencesManager.LanguageOptions.english
        
        var body: some View {
            VStack {
                Button("Show Language Picker") {
                    showLanguagePicker = true
                }
                .padding()
                
                Text("Selected: \(selectedLanguage.rawValue)")
                    .padding()
            }
            .sheet(isPresented: $showLanguagePicker) {
                EnumPickerModal(
                    title: "Preferred Language",
                    isPresented: $showLanguagePicker,
                    selectedItem: $selectedLanguage
                )
                .presentationDetents([.fraction(0.5)])
            }
        }
    }
    
    return PreviewWrapper()
}

