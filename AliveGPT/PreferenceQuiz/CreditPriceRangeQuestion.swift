//
//  CreditPriceRangeQuestion.swift
//  AliveGPT
//
//  Created by William Lopez on 10/15/25.
//

import SwiftUI

struct CreditPriceRangeQuestion: View {
    @Binding var hasNoPreference: Bool
    @Binding var minPrice: Double
    @Binding var maxPrice: Double
    
    let priceRange: ClosedRange<Double>
    
    init(
        hasNoPreference: Binding<Bool>,
        minPrice: Binding<Double>,
        maxPrice: Binding<Double>,
        priceRange: ClosedRange<Double> = 100...500
    ) {
        self._hasNoPreference = hasNoPreference
        self._minPrice = minPrice
        self._maxPrice = maxPrice
        self.priceRange = priceRange
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Price range in credits:")
                .font(.system(.caption2, weight: .medium))
                .foregroundColor(.black)
                .padding(.bottom, 25)
            
            CreditRangeSlider(
                lowerValue: $minPrice,
                upperValue: $maxPrice,
                range: priceRange,
                step: 1
            ).padding(.horizontal, 10)
            
            // Scale markers - positioned based on actual values
            GeometryReader { geo in
                let width = geo.size.width - 20 // Account for 20px padding on each side
                let valueRange = priceRange.upperBound - priceRange.lowerBound
                
                ZStack(alignment: .leading) {
                    ForEach([100, 200, 300, 400, 500], id: \.self) { value in
                        let normalized = CGFloat((Double(value) - priceRange.lowerBound) / valueRange)
                        let xPosition = normalized * width + 10 // Add left padding offset
                        
                        Text("\(value)")
                            .font(.system(size: 11))
                            .foregroundColor(.gray)
                            .offset(x: xPosition)
                            .frame(width: 30, alignment: .center)
                            .offset(x: -15) // Center the text (half of width)
                    }
                }
            }.frame(height: 30)
            
            Text("Tip: drag the handle to the nearest descriptor")
                .font(.system(.caption2, weight: .light))
                .foregroundColor(.black.opacity(0.7))
                .padding(.vertical, 12)
            
            HStack {
                Text("No Preference")
                    .font(.system(.caption2, weight: .light))
                    .foregroundColor(.black)
                
                Spacer()
                Button(action: {
                    hasNoPreference.toggle()
                    if hasNoPreference {
                        minPrice = priceRange.lowerBound
                        maxPrice = priceRange.upperBound
                    }
                }) {
                    if hasNoPreference {
                        Image(systemName: "circle.fill")
                            .foregroundStyle(.purple1).opacity(0.6)
                            .overlay(Circle().fill(.white).padding(6))
                        
                    } else {
                        Image(systemName: "circle")
                            .foregroundStyle(.black)
                            .fontWeight(.ultraLight)
                    }
                }
            }
        }
    }
}


#Preview {
    struct PreviewWrapper: View {
        @State private var hasNoPreference = false
        @State private var minPrice: Double = 143
        @State private var maxPrice: Double = 314
        
        var body: some View {
            VStack(spacing: 20) {
                CreditPriceRangeQuestion(
                    hasNoPreference: $hasNoPreference,
                    minPrice: $minPrice,
                    maxPrice: $maxPrice,
                    priceRange: 0...600
                )
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.1))
        }
    }
    
    return PreviewWrapper()
}
