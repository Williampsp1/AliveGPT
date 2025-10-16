//
//  SmartMatchingCard.swift
//  AliveGPT
//
//  Created by William Lopez on 10/16/25.

import SwiftUI

struct SmartMatchingCard: View {
    let item: SmartMatchingItem
    let onViewNow: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
            instructorInfo
            ratingsAndDetails
            footer
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .stroke(.black.opacity(0.33), lineWidth: 0.5)
        )
    }
    
    @ViewBuilder
    private var header: some View {
        HStack {
            Image(systemName: "arrowshape.turn.up.right.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.black)
                .frame(height: 12)
            Spacer()
            Image(.star)
                .resizable()
                .scaledToFit()
                .frame(height: 18)
        }
        .padding(.bottom, 12)
        
        // Content Type Badge and Access Type
        HStack {
            HStack(spacing: 4) {
                Text(item.contentType.displayText)
                    .font(.caption)
                    .foregroundColor(.black)
                
            }
            .padding(4)
            .background {
                RoundedRectangle(cornerRadius: 6)
                    .fill(item.contentType.badgeColor)
            }
            if let date = item.liveDate {
                Text(date)
                    .font(.system(.caption2, weight: .light))
                    .foregroundColor(.black.opacity(0.6))
            }
            Spacer()
            
            if let accessType = item.accessType {
                HStack {
                    Image(accessType.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 12)
                    Text(accessType.displayText)
                        .font(.system(.caption, weight: .medium))
                        .foregroundColor(.black)
                }
                .padding(4)
                .background {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.lightGreen)
                        
                }
            }
        }
        .padding(.bottom, 16)
        Text(item.title)
            .fontWeight(.medium)
            .foregroundColor(.black)
            .padding(.bottom, 8)
    }
    
    @ViewBuilder
    private var instructorInfo: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(.purple3)
                .stroke(.black.opacity(0.33), lineWidth: 0.5)
                .frame(width: 32, height: 32)
            
            Text(item.instructorName)
                .foregroundColor(.black)
            
            Text(item.instructorBadge.rawValue)
                .font(.system(.caption, weight: .light))
                    .foregroundColor(.black)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(item.instructorBadge.badgeColor)
                            .stroke(.black.opacity(0.5), lineWidth: 0.5)
                    )
        }
        .padding(.bottom, 18)
    }
    
    @ViewBuilder
    private var ratingsAndDetails: some View {
        HStack(spacing: 6) {
            HStack(spacing: 3) {
                Image(.ratingStar)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                Text("\(item.rating, specifier: "%.1f")")
                    .font(.system(.caption, weight: .medium))
                    .foregroundColor(.black)
                Text("(\(item.reviewCount))")
                    .font(.system(.caption2, weight: .light))
                    .foregroundColor(.black.opacity(0.6))
            }
            // Duration (for live sessions)
            if let duration = item.duration {
                Circle()
                    .fill(.gray)
                    .frame(width: 3, height: 3)
                Image(systemName: "clock.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(.green)
                Text("\(duration) min")
                    .font(.system(.caption, weight: .medium))
                    .foregroundColor(.black)
            }
            
            // Attendees (for group sessions)
            if let attendees = item.attendees {
                Circle()
                    .fill(.gray)
                    .frame(width: 3, height: 3)
                Image(.groupGreen)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.green)
                Text(attendees)
                    .font(.system(.caption, weight: .medium))
                    .foregroundColor(.black)
            }
            
            // Access Period (for fixed circles)
            if let accessPeriod = item.accessPeriod {
                Circle()
                    .fill(.gray)
                    .frame(width: 3, height: 3)
                Image(.time)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                Text(accessPeriod)
                    .font(.system(.caption, weight: .medium))
                    .foregroundStyle(.black)
                    .lineLimit(1)
            }
            
            // Member Count (for circles)
            if let memberCount = item.memberCount {
                Circle()
                    .fill(.gray)
                    .frame(width: 3, height: 3)
                Image(.groupGreen)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                Text("\(memberCount) members")
                    .font(.system(.caption, weight: .medium))
                    .foregroundColor(.black)
            }
            
            // Bought Count (for digital content)
            if let boughtCount = item.boughtCount {
                Circle()
                    .fill(.gray)
                    .frame(width: 3, height: 3)
                Image(.groupGreen)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                Text("\(boughtCount) Bought")
                    .font(.system(.caption, weight: .medium))
                    .foregroundColor(.black)
            }
        }
        .padding(.bottom, 16)
        Text(item.description)
            .font(.system(.caption, weight: .light))
            .foregroundColor(.black.opacity(0.6))
            .lineLimit(4)
            .padding(.bottom, 20)
    }
    
    private var footer: some View {
        HStack {
            HStack {
                Image(.starsColored)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .padding(.trailing, -2)
                Text("\(item.matchPercentage)")
                    .font(.system(.caption, weight: .semibold))
                    .foregroundColor(.black)
                    .padding(.trailing, -8)
                Text("% match for you")
                    .font(.system(.caption2, weight: .light))
                    .foregroundColor(.black.opacity(0.6))
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                Image(.token)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                Text("\(item.credits) credits")
                    .font(.system(.caption2, weight: .light))
                    .foregroundColor(.black.opacity(0.6))
            }
            
            Button(action: onViewNow) {
                Text("View Now")
                    .font(.system(.caption, weight: .medium))
                    .foregroundColor(.black)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 5)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.purple9)
                            .stroke(.purple5, lineWidth: 0.5)
                    )
            }
        }
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 20) {
            // 1:1 Live Session Example
            SmartMatchingCard(
                item: SmartMatchingItem(
                    matchingType: "1:1",
                    contentType: .liveSession,
                    accessType: .oneOnOne,
                    liveDate: nil,
                    title: "Waylon Smithers 1:1 Session",
                    instructorName: "Waylon Smithers",
                    instructorBadge: .t1,
                    rating: 4.7,
                    reviewCount: 167,
                    duration: nil,
                    attendees: nil,
                    accessPeriod: nil,
                    memberCount: nil,
                    boughtCount: nil,
                    description: "Curabitur commodo, sapien sit amet sodales egestas, mi tortor vestibulum lectus, eget egestas nulla eros id tellus. Morbi rhoncus ante orci, in vulputate ex lobortis eu. Mauris at blandit mi, a tempor ligula.",
                    matchPercentage: 92,
                    credits: 100,
                    isFavorited: true
                ),
                onViewNow: {}
            )
            .padding(.horizontal)
            
            // Group Live Session Example
            SmartMatchingCard(
                item: SmartMatchingItem(
                    matchingType: "Group",
                    contentType: .liveSession,
                    accessType: .group,
                    liveDate: "Sep 19, 2025 at 9am",
                    title: "7 Day Breathwork Workbook",
                    instructorName: "Waylon Smithers",
                    instructorBadge: .t2,
                    rating: 4.7,
                    reviewCount: 167,
                    duration: 30,
                    attendees: "9/10 people",
                    accessPeriod: nil,
                    memberCount: nil,
                    boughtCount: nil,
                    description: "Curabitur commodo, sapien sit amet sodales egestas, mi tortor vestibulum lectus, eget egestas nulla eros id tellus. Morbi rhoncus ante orci, in vulputate ex lobortis eu. Mauris at blandit mi, a tempor ligula.",
                    matchPercentage: 92,
                    credits: 100,
                    isFavorited: true
                ),
                onViewNow: {}
            )
            .padding(.horizontal)
            
            // Fixed Circle Example
            SmartMatchingCard(
                item: SmartMatchingItem(
                    matchingType: "Fixed Circle",
                    contentType: .fixedCircle,
                    accessType: .public,
                    liveDate: "Sept 9, 2025 - Jan 9, 2026",
                    title: "7 Day Breathwork Workbook",
                    instructorName: "Waylon Smithers",
                    instructorBadge: .t3,
                    rating: 4.7,
                    reviewCount: 167,
                    duration: nil,
                    attendees: nil,
                    accessPeriod: "Four Months Access",
                    memberCount: 32,
                    boughtCount: nil,
                    description: "Curabitur commodo, sapien sit amet sodales egestas, mi tortor vestibulum lectus, eget egestas nulla eros id tellus. Morbi rhoncus ante orci, in vulputate ex lobortis eu. Mauris at blandit mi, a tempor ligula.",
                    matchPercentage: 92,
                    credits: 100,
                    isFavorited: true
                ),
                onViewNow: {}
            )
            .padding(.horizontal)
            
            // Ongoing Circle Example
            SmartMatchingCard(
                item: SmartMatchingItem(
                    matchingType: "Ongoing Circle",
                    contentType: .ongoingCircle,
                    accessType: .public,
                    liveDate: nil,
                    title: "7 Day Breathwork Workbook",
                    instructorName: "Waylon Smithers",
                    instructorBadge: .t1,
                    rating: 4.7,
                    reviewCount: 167,
                    duration: nil,
                    attendees: nil,
                    accessPeriod: nil,
                    memberCount: 32,
                    boughtCount: nil,
                    description: "Curabitur commodo, sapien sit amet sodales egestas, mi tortor vestibulum lectus, eget egestas nulla eros id tellus. Morbi rhoncus ante orci, in vulputate ex lobortis eu. Mauris at blandit mi, a tempor ligula.",
                    matchPercentage: 92,
                    credits: 100,
                    isFavorited: true
                ),
                onViewNow: {}
            )
            .padding(.horizontal)
            
            // Digital Content Example
            SmartMatchingCard(
                item: SmartMatchingItem(
                    matchingType: "Digital Content",
                    contentType: .digitalContent,
                    accessType: nil,
                    liveDate: nil,
                    title: "Foundations of Mobility",
                    instructorName: "Waylon Smithers",
                    instructorBadge: .t3,
                    rating: 4.7,
                    reviewCount: 167,
                    duration: nil,
                    attendees: nil,
                    accessPeriod: nil,
                    memberCount: nil,
                    boughtCount: 32,
                    description: "Curabitur commodo, sapien sit amet sodales egestas, mi tortor vestibulum lectus, eget egestas nulla eros id tellus. Morbi rhoncus ante orci, in vulputate ex lobortis eu. Mauris at blandit mi, a tempor ligula.",
                    matchPercentage: 92,
                    credits: 100,
                    isFavorited: true
                ),
                onViewNow: {}
            )
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
    .background(.aliveGPTBG)
}

