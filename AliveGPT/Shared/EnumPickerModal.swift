//
//  LanguagePickerModal.swift
//  AliveGPT
//
//  Created by William Lopez on 10/14/25.
//

import SwiftUI

protocol PickerEnum: CaseIterable, RawRepresentable, Hashable where RawValue == String {}
struct EnumPickerModal<EnumType: PickerEnum>: View {
    let title: String
    @Binding var isPresented: Bool
    @Binding var selectedItem: EnumType

    @State private var selectedIndex: Int? = 0
    private let allItems: [EnumType] = Array(EnumType.allCases)
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                Spacer()
                Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "xmark")
                }.foregroundColor(.black)
            }
            .font(.headline)
            .fontWeight(.semibold)
            
            Spacer()
            
            CustomWheelPicker(options: allItems.map({ $0.rawValue }), selectedIndex: $selectedIndex).frame(height: 200)
            
            Spacer()
            
            Button(action: {
                selectedItem = allItems[selectedIndex ?? (allItems.count/2) - 1]
                isPresented = false
            }) {
                Text("Submit")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.black)
                    .cornerRadius(15)
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 20)
        .task {
            // Set the initial index of the picker to match the currently selected item.
            if let initialIndex = allItems.firstIndex(of: selectedItem) {
                selectedIndex = initialIndex
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
