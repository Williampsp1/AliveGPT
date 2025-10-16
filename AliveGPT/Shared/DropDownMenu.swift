//
//  DropDownMenu.swift
//  AliveGPT
//
//  Created by William Lopez on 10/8/25.
//

import SwiftUI

struct DropDownMenu: View {
    let options: [String]
    var menuWdith: CGFloat = 155
    var buttonHeight: CGFloat = 30
    var maxItemDisplayed: Int = 4
    
    @Binding var selectedOptionIndex: Int
    @Binding var showDropdown: Bool
    
    @State private var scrollPosition: Int?
    
    var body: some  View {
        VStack {
            VStack {
                // selected item
                Button(action: {
                    withAnimation {
                        showDropdown.toggle()
                    }
                }, label: {
                    HStack(spacing: 3) {
                        Text(options[selectedOptionIndex])
                            .fontWeight(.medium)
                            .lineLimit(1)
                        Image(systemName: "chevron.down")
                            .font(.caption2)
                            .rotationEffect(.degrees((showDropdown ?  -180 : 0)))
                    }
                })
                .font(.footnote)
                .padding(.horizontal, 15)
                .frame(width: menuWdith, height: buttonHeight, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 20).stroke(.black.opacity(0.5), lineWidth: 1))
                
                // selection menu
                if (showDropdown) {
                    let scrollViewHeight: CGFloat  = options.count > maxItemDisplayed ? (buttonHeight*CGFloat(maxItemDisplayed)) : (buttonHeight*CGFloat(options.count))
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            Spacer()
                            ForEach(0..<options.count, id: \.self) { index in
                                Button(action: {
                                    withAnimation {
                                        selectedOptionIndex = index
                                        showDropdown.toggle()
                                    }
                                    
                                }, label: {
                                    HStack {
                                        Text(options[index])
                                            .lineLimit(1)
                                            .padding(.vertical, 5)
                                            .padding(.horizontal, 10)
                                            .fontWeight(index == selectedOptionIndex ? .medium : .light)
                                    }
                                    
                                })
                                .background {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(index == selectedOptionIndex ? .white : .clear)
                                        .stroke(index == selectedOptionIndex ? .black.opacity(0.3) : .clear, lineWidth: 0.33)
                                }
                                .font(.footnote)
                                .padding(.horizontal, 10)
                                .frame(height: buttonHeight, alignment: .center)
                            }
                            Spacer()
                        }
                        .scrollTargetLayout()
                    }
                    .scrollPosition(id: $scrollPosition)
                    .scrollDisabled(options.count <=  4)
                    .frame(width: 145, height: scrollViewHeight + 20)
                    .onAppear {
                        scrollPosition = selectedOptionIndex
                    }
                    .background(RoundedRectangle(cornerRadius: 20)
                        .fill(.aliveGPTBG)
                        .stroke(.black, lineWidth: 1))
                }
            }
            .foregroundStyle(Color.black)
        }
        .frame(width: menuWdith, height: buttonHeight, alignment: .top)
        .zIndex(100)
    }
}

#Preview {
    @Previewable @State var showDropdown: Bool = false
    @Previewable @State var selectedOptionIndex: Int = 1
    DropDownMenu(options: ["1", "2", "3"], selectedOptionIndex: $selectedOptionIndex, showDropdown: $showDropdown)
}
