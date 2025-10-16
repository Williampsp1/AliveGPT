//
//  CreditRangeSlider.swift
//  AliveGPT
//
//  Created by William Lopez on 10/14/25.
//

import SwiftUI

struct CreditRangeSlider: View {
    @Binding var lowerValue: Double
    @Binding var upperValue: Double
    
    let range: ClosedRange<Double>
    let step: Double
    
    @State private var isDraggingLower = false
    @State private var isDraggingUpper = false
    
    private let trackHeight: CGFloat = 8
    private let thumbSize: CGFloat = 20
    
    init(
        lowerValue: Binding<Double>,
        upperValue: Binding<Double>,
        range: ClosedRange<Double>,
        step: Double = 1
    ) {
        self._lowerValue = lowerValue
        self._upperValue = upperValue
        self.range = range
        self.step = step
    }
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let valueRange = range.upperBound - range.lowerBound
            
            // Calculate normalized positions (0.0 to 1.0)
            let lowerNormalized = CGFloat((lowerValue - range.lowerBound) / valueRange)
            let upperNormalized = CGFloat((upperValue - range.lowerBound) / valueRange)
            
            // Convert to pixel positions
            let lowerX = lowerNormalized * width
            let upperX = upperNormalized * width
            
            ZStack {
                // Background track
                Capsule()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: trackHeight)
                    .frame(maxHeight: .infinity)
                
                // Active track
                Capsule()
                    .fill(.purple4)
                    .frame(width: upperX - lowerX, height: trackHeight)
                    .offset(x: lowerX)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                
                // Lower thumb
                thumbView(value: lowerValue, isDragging: isDraggingLower)
                    .offset(x: lowerX - thumbSize - 8, y: -thumbSize + 4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                isDraggingLower = true
                                updateLowerValue(dragX: gesture.location.x, width: width)
                            }
                            .onEnded { _ in
                                isDraggingLower = false
                            }
                    )
                
                // Upper thumb
                thumbView(value: upperValue, isDragging: isDraggingUpper)
                    .offset(x: upperX - thumbSize - 8, y: -thumbSize + 4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                isDraggingUpper = true
                                updateUpperValue(dragX: gesture.location.x, width: width)
                            }
                            .onEnded { _ in
                                isDraggingUpper = false
                            }
                    )
            }
        }.frame(height: 35)
    }
    
    @ViewBuilder
    private func thumbView(value: Double, isDragging: Bool) -> some View {
        VStack(spacing: 8) {
            // Value label
            HStack(spacing: 3) {
                Image("token")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14)
                Text("\(Int(value))")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            
            // Thumb circle
            Circle()
                .fill(.purple5)
                .frame(width: thumbSize, height: thumbSize)
                .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                .overlay(
                    Circle()
                        .fill(.white)
                        .frame(width: 10, height: 10)
                )
                .scaleEffect(isDragging ? 1.15 : 1.0)
                .animation(.spring(response: 0.3), value: isDragging)
        }
    }
    
    private func updateLowerValue(dragX: CGFloat, width: CGFloat) {
        let normalized = max(0, min(1, dragX / width))
        let valueRange = range.upperBound - range.lowerBound
        let newValue = normalized * valueRange + range.lowerBound
        let steppedValue = round(newValue / step) * step
        lowerValue = min(max(range.lowerBound, steppedValue), upperValue - step)
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    private func updateUpperValue(dragX: CGFloat, width: CGFloat) {
        let normalized = max(0, min(1, dragX / width))
        let valueRange = range.upperBound - range.lowerBound
        let newValue = normalized * valueRange + range.lowerBound
        let steppedValue = round(newValue / step) * step
        upperValue = max(min(range.upperBound, steppedValue), lowerValue + step)
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}

// MARK: - Credit Price Range Picker

// MARK: - Preview
#Preview {
    struct PreviewWrapper: View {
        @State private var hasNoPreference = false
        @State private var minPrice: Double = 143
        @State private var maxPrice: Double = 314
        
        var body: some View {
            VStack(spacing: 20) {
                CreditRangeSlider(
                    lowerValue: $minPrice,
                    upperValue: $maxPrice,
                    range: 0...600,
                    step: 1
                )
                .padding(.horizontal, 24)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.1))
        }
    }
    
    return PreviewWrapper()
}

