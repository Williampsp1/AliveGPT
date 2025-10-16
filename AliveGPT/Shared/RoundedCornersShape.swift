//
//  RoundedCornersShape.swift
//  AliveGPT
//
//  Created by William Lopez on 10/8/25.
//

import Foundation
import SwiftUI

// Helper shape to round specific corners of a rectangle
struct RoundedCornersShape: Shape {
    var radius: CGFloat = 20
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
