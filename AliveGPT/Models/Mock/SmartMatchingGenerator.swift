//
//  SmartMatchingGenerator.swift
//  AliveGPT
//
//  Created by William Lopez on 10/16/25.
//

import Foundation

enum SmartMatchingGenerator {
    private static let sessionTitles = [
        "Personal Growth Journey Session",
        "Mindfulness & Meditation Practice",
        "Career Development Coaching",
        "Stress Management Workshop",
        "Life Balance Consultation",
        "Confidence Building Session",
        "Relationship Dynamics Discussion",
        "Creative Expression Workshop",
        "Goal Setting & Achievement",
        "Emotional Intelligence Training"
    ]
    
    private static let circleTitles = [
        "7 Day Breathwork Workbook",
        "Morning Meditation Circle",
        "Wellness Warriors Community",
        "Creative Writers Collective",
        "Mindful Movement Practice",
        "Personal Development Journey",
        "Gratitude & Positivity Circle",
        "Digital Detox Challenge",
        "Self-Care Sundays",
        "Entrepreneurial Minds Network"
    ]
    
    private static let digitalContentTitles = [
        "Foundations of Mobility",
        "Complete Yoga Guide",
        "Meditation Masterclass",
        "Nutrition Essentials",
        "Sleep Optimization Course",
        "Stress Relief Techniques",
        "Energy Management System",
        "Mindful Communication Skills",
        "Building Resilience",
        "Work-Life Integration"
    ]
    
    private static let instructorNames = [
        "Sarah Chen",
        "Marcus Johnson",
        "Elena Rodriguez",
        "David Park",
        "Aisha Williams",
        "James O'Connor",
        "Priya Sharma",
        "Michael Anderson",
        "Sofia Martinez",
        "Alex Thompson"
    ]
    
    private static let descriptions = [
        "Transform your daily practice with evidence-based techniques designed to enhance your wellbeing and personal growth journey.",
        "Join a supportive community focused on sustainable change through mindful awareness and intentional action.",
        "Discover powerful tools and strategies that will help you navigate life's challenges with greater ease and confidence.",
        "An immersive experience combining ancient wisdom with modern science to optimize your mental and physical health.",
        "Connect with like-minded individuals while exploring proven methods for lasting transformation and fulfillment."
    ]
    
    static func generateLiveSession() -> SmartMatchingItem {
        let isOneOnOne = Bool.random()
        
        return SmartMatchingItem(
            matchingType: isOneOnOne ? "1:1" : "Group",
            contentType: .liveSession,
            accessType: isOneOnOne ? .oneOnOne : .group,
            liveDate: isOneOnOne ? nil : generateFutureDate(),
            title: sessionTitles.randomElement()!,
            instructorName: instructorNames.randomElement()!,
            instructorBadge: InstructorBadgeType.allCases.randomElement()!,
            rating: Double.random(in: 4.3...4.9).rounded(toPlaces: 1),
            reviewCount: Int.random(in: 45...250),
            duration: isOneOnOne ? nil : [30, 45, 60, 90].randomElement()!,
            attendees: isOneOnOne ? nil : "\(Int.random(in: 5...15))/\(Int.random(in: 10...20)) people",
            accessPeriod: nil,
            memberCount: nil,
            boughtCount: nil,
            description: descriptions.randomElement()!,
            matchPercentage: Int.random(in: 75...98),
            credits: [50, 75, 100, 125, 150].randomElement()!,
            isFavorited: Bool.random()
        )
    }
    
    static func generateCircle() -> SmartMatchingItem {
        let isFixed = Bool.random()
        
        return SmartMatchingItem(
            matchingType: isFixed ? "Fixed Circle" : "Ongoing Circle",
            contentType: isFixed ? .fixedCircle : .ongoingCircle,
            accessType: .public,
            liveDate: isFixed ? generateDateRange() : nil,
            title: circleTitles.randomElement()!,
            instructorName: instructorNames.randomElement()!,
            instructorBadge: InstructorBadgeType.allCases.randomElement()!,
            rating: Double.random(in: 4.3...4.9).rounded(toPlaces: 1),
            reviewCount: Int.random(in: 80...300),
            duration: nil,
            attendees: nil,
            accessPeriod: isFixed ? ["Two Months Access", "Three Months Access", "Four Months Access"].randomElement()! : nil,
            memberCount: Int.random(in: 15...150),
            boughtCount: nil,
            description: descriptions.randomElement()!,
            matchPercentage: Int.random(in: 75...98),
            credits: [75, 100, 125, 150, 200].randomElement()!,
            isFavorited: Bool.random()
        )
    }
    
    static func generateDigitalContent() -> SmartMatchingItem {
        SmartMatchingItem(
            matchingType: "Digital Content",
            contentType: .digitalContent,
            accessType: nil,
            liveDate: nil,
            title: digitalContentTitles.randomElement()!,
            instructorName: instructorNames.randomElement()!,
            instructorBadge: InstructorBadgeType.allCases.randomElement()!,
            rating: Double.random(in: 4.3...4.9).rounded(toPlaces: 1),
            reviewCount: Int.random(in: 100...500),
            duration: nil,
            attendees: nil,
            accessPeriod: nil,
            memberCount: nil,
            boughtCount: Int.random(in: 25...200),
            description: descriptions.randomElement()!,
            matchPercentage: Int.random(in: 75...98),
            credits: [25, 50, 75, 100].randomElement()!,
            isFavorited: Bool.random()
        )
    }
    
    private static func generateFutureDate() -> String {
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let day = Int.random(in: 1...28)
        let month = months.randomElement()!
        let hour = Int.random(in: 8...18)
        let ampm = hour >= 12 ? "pm" : "am"
        let displayHour = hour > 12 ? hour - 12 : hour
        
        return "\(month) \(day), 2025 at \(displayHour)\(ampm)"
    }
    
    private static func generateDateRange() -> String {
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let startMonth = months.randomElement()!
        let endMonth = months.randomElement()!
        let startDay = Int.random(in: 1...28)
        let endDay = Int.random(in: 1...28)
        
        return "\(startMonth) \(startDay), 2025 - \(endMonth) \(endDay), 2026"
    }
}

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension InstructorBadgeType: CaseIterable {
    static var allCases: [InstructorBadgeType] {
        [.t1, .t2, .t3]
    }
}

