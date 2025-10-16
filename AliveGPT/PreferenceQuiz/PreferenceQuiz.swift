//
//  PreferenceQuiz.swift
//  AliveGPT
//
//  Created by William Lopez on 10/12/25.
//

import SwiftUI

struct PreferenceQuiz: View {
    @Environment(PreferencesManager.self) private var preferences: PreferencesManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        @Bindable var preferences = preferences
        VStack {
            header.padding(.bottom, 10)

            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Text("We’ll match you as best as we can with providers and services tailored to your preferences.\nFill out your preferences for a provider! You may change these any time.")
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                        .font(.system(.caption2, weight: .medium))
                    Divider()
                    genderSection
                    Divider()
                    ageSection
                    Divider()
                    tierSection
                    Divider()
                    languageSection
                    Divider()
                    countrySection
                    Divider()
                    timeZoneSection
                    Divider()
                    serviceTypeSection
                    Divider()
                    CreditPriceRangeQuestion(hasNoPreference: $preferences.noCreditRange, minPrice: $preferences.minPrice, maxPrice: $preferences.maxPrice, priceRange: 0...600)
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.white)
                }
            }
        }
        .padding(.horizontal, 15)
        .background(.aliveGPTBG)
        .blur(radius: preferences.showLanguageModal ? 5 : 0)
        .safeAreaInset(edge: .bottom) {
            VStack {
                Button(action: {
                    preferences.savePreferences()
                    dismiss()
                }) {
                    Text("Save")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 58)
                        .background {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.purple3)
                                .stroke(.black.opacity(0.33), lineWidth: 0.5)
                        }
                }.padding(16)
            }
        }
        .sheet(isPresented: $preferences.showLanguageModal) {
            EnumPickerModal(title: "Preferred language", isPresented: $preferences.showLanguageModal, selectedItem: $preferences.language)
                .presentationDetents([.fraction(0.5)])
        }
        .sheet(isPresented: $preferences.showCountryModal) {
            EnumPickerModal(title: "Preferred country:", isPresented: $preferences.showCountryModal, selectedItem: $preferences.country)
                .presentationDetents([.fraction(0.5)])
        }
        .sheet(isPresented: $preferences.showTimeZoneModal) {
            EnumPickerModal(title: "Preferred Time Zone:", isPresented: $preferences.showTimeZoneModal, selectedItem: $preferences.timeZone)
                .presentationDetents([.fraction(0.5)])
        }
        .navigationBarBackButtonHidden()
    }
    
    var header: some View {
        ZStack {
            HStack(alignment: .center) {
                Button(action: {
                    dismiss()
                }) {
                    HStack(spacing: 2) {
                        Image(systemName: "chevron.left")
                        Text("AliveGPT").font(.caption)
                    }
                }
                Spacer()
            }
            .foregroundStyle(.black)
            .padding(.vertical, 24)
            .padding(.horizontal, 15)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.smartMatchingHeader)
                    .stroke(.black.opacity(0.15), lineWidth: 0.4)
                    .shadow(color: .black.opacity(0.12), radius: 1.5)
            }
            Text("Smart Matching")
                .font(.system(.footnote, weight: .medium))
                .foregroundStyle(.black)
        }
    }

    // MARK: - Quiz Sections
    var genderSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Your preferred provider gender:")
                .font(.system(.caption2, weight: .medium))
                .foregroundStyle(.black)
            ForEach(PreferencesManager.GenderOption.allCases, id: \.self) { genderOption in
                HStack {
                    Text(genderOption.rawValue)
                        .font(.system(.caption2, weight: .light))
                        .foregroundStyle(.black)
                    Spacer()
                    Button(action: {
                        withAnimation(.snappy) {
                            preferences.gender = genderOption
                        }
                    }) {
                        if genderOption == preferences.gender {
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

    var ageSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Your preferred provider age:")
                .font(.system(.caption2, weight: .medium))
                .foregroundStyle(.black)
            ForEach(PreferencesManager.AgeOption.allCases, id: \.self) { ageOption in
                HStack {
                    Text(ageOption.rawValue)
                        .font(.system(.caption2, weight: .light))
                        .foregroundStyle(.black)
                    Spacer()
                    Button(action: {
                        withAnimation(.snappy) {
                            preferences.age = ageOption
                        }
                    }) {
                        if ageOption == preferences.age {
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

    var tierSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Your preferred provider tier:")
                .font(.system(.caption2, weight: .medium))
                .foregroundStyle(.black)
            ForEach(PreferencesManager.TierOptions.allCases, id: \.self) { tierOption in
                HStack {
                    Text(tierOption.rawValue)
                        .font(.system(.caption2, weight: .light))
                        .foregroundStyle(.black)
                    Spacer()
                    Button(action: {
                        withAnimation(.snappy) {
                            preferences.tier = tierOption
                        }
                    }) {
                        if tierOption == preferences.tier {
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

    var languageSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Your preferred provider's language:")
                .font(.system(.caption2, weight: .medium))
                .foregroundStyle(.black)
            Button(action: {
                preferences.showLanguageModal.toggle()
            }) {
                HStack {
                    Text(preferences.language.rawValue)
                        .font(.system(.caption2, weight: .light))
                        .foregroundStyle(.black)
                    Spacer()
                    Image(.arrow)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .padding(8)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.black.opacity(0.33), lineWidth: 0.5)
                }
            }
            HStack {
                Text("No preference")
                    .font(.system(.caption2, weight: .light))
                    .foregroundStyle(.black)
                Spacer()
                Button(action: {
                    withAnimation(.snappy) {
                        preferences.noLanguage.toggle()
                    }
                }) {
                    if preferences.noLanguage {
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

    var countrySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Your provider’s preferred country:")
                .font(.system(.caption2, weight: .medium))
                .foregroundStyle(.black)
            Button(action: {
                preferences.showCountryModal.toggle()
            }) {
                HStack {
                    Text(preferences.country.rawValue)
                        .font(.system(.caption2, weight: .light))
                        .foregroundStyle(.black)
                    Spacer()
                    Image(.arrow)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .padding(8)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.black.opacity(0.33), lineWidth: 0.5)
                }
            }
            HStack {
                Text("No preference")
                    .font(.system(.caption2, weight: .light))
                    .foregroundStyle(.black)
                Spacer()
                Button(action: {
                    withAnimation(.snappy) {
                        preferences.noCountry.toggle()
                    }
                }) {
                    if preferences.noCountry {
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

    var timeZoneSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Your preferred time zone:")
                .font(.system(.caption2, weight: .medium))
                .foregroundStyle(.black)
            Button(action: {
                preferences.showTimeZoneModal.toggle()
            }) {
                HStack {
                    Text(preferences.timeZone.rawValue)
                        .font(.system(.caption2, weight: .light))
                        .foregroundStyle(.black)
                    Spacer()
                    Image(.arrow)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .padding(8)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.black.opacity(0.33), lineWidth: 0.5)
                }
            }
            HStack {
                Text("No preference")
                    .font(.system(.caption2, weight: .light))
                    .foregroundStyle(.black)
                Spacer()
                Button(action: {
                    withAnimation(.snappy) {
                        preferences.noTimeZone.toggle()
                    }
                }) {
                    if preferences.noTimeZone {
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

    var serviceTypeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Your preferred service type:")
                .font(.system(.caption2, weight: .medium))
                .foregroundStyle(.black)
            ForEach(PreferencesManager.ServiceTypeOptions.allCases, id: \.self) { service in
                HStack {
                    Text(service.rawValue)
                        .font(.system(.caption2, weight: .light))
                        .foregroundStyle(.black)
                    Spacer()
                    Button(action: {
                        withAnimation(.snappy) {
                            preferences.serviceType = service
                        }
                    }) {
                        if service == preferences.serviceType {
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
}

#Preview {
    PreferenceQuiz().environment(PreferencesManager())
}
