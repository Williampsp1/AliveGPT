//
//  PreferencesManager.swift
//  AliveGPT
//
//  Created by William Lopez on 10/13/25.
//

import Foundation

@Observable class PreferencesManager {
    var gender: GenderOption?
    var age: AgeOption?
    var tier: TierOptions?
    var language: LanguageOptions = .english
    var country: CountryOptions = .usa
    var timeZone: TimeZoneOptions = .timeZone4
    var serviceType: ServiceTypeOptions?
    var minPrice: Double = 143
    var maxPrice: Double = 314
    
    var noTimeZone = false
    var noLanguage = false
    var noCountry = false
    var noCreditRange = false
    var showLanguageModal = false
    var showCountryModal = false
    var showTimeZoneModal = false
    var preferencesSaved = false
    
    enum TimeZoneOptions: String, PickerEnum {
        case timeZone1 = "Time zone 1"
        case timeZone2 = "Time zone 2"
        case timeZone3 = "Time zone 3"
        case timeZone4 = "Time zone 4"
        case timeZone5 = "Time zone 5"
        case timeZone6 = "Time zone 6"
        case timeZone7 = "Time zone 7"
    }
    
    enum CountryOptions: String, PickerEnum {
        case something = "Something"
        case morroco = "Morocco"
        case italy = "Italy"
        case usa = "USA"
        case uk = "United Kingdom"
        case spain = "Spain"
        case germany = "Germany"
    }
    
    enum LanguageOptions: String, PickerEnum {
        case something = "Something"
        case something2 = "Something2"
        case spanish = "Spanish"
        case english = "English"
        case french = "French"
        case greek = "Greek"
        case something3 = "Something3"
        
    }
    
    enum GenderOption: String, CaseIterable {
        case male =  "Male"
        case female = "Female"
        case noPreference = "No Preference"
        case other = "Other"
    }
    
    enum AgeOption: String, CaseIterable {
        case age18To29 = "18-29"
        case age30To39 = "30-39"
        case age40To49 = "40-49"
        case age50To59 = "50-59"
        case age60Plus = "60+"
        case noPreference = "No Preference"
    }
    
    enum TierOptions: String, CaseIterable {
        case t1 = "T1 (entry-level, starting out)"
        case t2 = "T2 (certified or formally trained)"
        case t3 = "T3 (top-rated, highly experienced)"
        case noPreference = "No Preference"
    }
    
    enum ServiceTypeOptions: String, CaseIterable {
        case oneOnOne = "1 on 1 session"
        case group = "Group session"
        case circle = "Circle"
        case digital = "Digital content"
        case noPreference = "No Preference"
    }
    
    func savePreferences() {
        preferencesSaved = true
    }
}
