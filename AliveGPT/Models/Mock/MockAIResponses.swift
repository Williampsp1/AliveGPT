//
//  MockAIResponses.swift
//  AliveGPT
//
//  Created by William Lopez on 10/13/25.
//

import Foundation

enum MockAIResponses {
    
    // MARK: - Stress & Anxiety Responses
    static let stressResponses = [
        "I understand you're feeling stressed. Try taking 5 deep breaths - inhale for 4 counts, hold for 4, exhale for 6. This activates your parasympathetic nervous system and can help you feel calmer.",
        "Stress is a normal response, but managing it is important. Consider trying a 5-minute mindfulness exercise: focus on 5 things you can see, 4 you can hear, 3 you can touch, 2 you can smell, and 1 you can taste.",
        "When stress builds up, our bodies tense. Try progressive muscle relaxation: tense each muscle group for 5 seconds, then release. Start with your toes and work your way up to your head.",
        "Stress often comes from feeling overwhelmed. Try breaking down your tasks into smaller, manageable steps. What's one small thing you could accomplish right now?"
    ]
    
    // MARK: - Sleep Responses
    static let sleepResponses = [
        "Good sleep is crucial for wellness. Try creating a bedtime routine: dim lights 1 hour before bed, avoid screens, and keep your room cool (60-67°F). Your brain needs this wind-down time.",
        "Sleep troubles are common. Consider the 4-7-8 breathing technique: breathe in for 4, hold for 7, exhale for 8. This can help activate your body's relaxation response.",
        "Your sleep environment matters. Make sure your room is dark, quiet, and cool. If your mind races at bedtime, try keeping a journal by your bed to write down tomorrow's worries.",
        "Consistency helps regulate your circadian rhythm. Try to go to bed and wake up at the same time every day, even on weekends. Your body thrives on routine."
    ]
    
    // MARK: - Exercise & Fitness Responses
    static let exerciseResponses = [
        "Movement is medicine for both body and mind. Even 10 minutes of walking can boost endorphins and improve mood. What type of movement feels good to you today?",
        "Exercise doesn't have to be intense to be beneficial. Try starting with 5-10 minutes of gentle stretching or a short walk. The key is consistency, not intensity.",
        "Physical activity releases natural mood boosters. If you're new to exercise, try the 'two-minute rule' - commit to just 2 minutes of movement. Often you'll naturally want to continue.",
        "Find movement you enjoy! Dancing, gardening, playing with pets, or taking stairs instead of elevators all count. The best exercise is the one you'll actually do."
    ]
    
    // MARK: - Mental Health Responses
    static let mentalHealthResponses = [
        "Your mental health matters. Remember that it's okay to have difficult days - they don't define you. What's one small thing that usually brings you a bit of joy?",
        "Mental wellness is a journey, not a destination. Be patient and kind with yourself. Progress isn't always linear, and that's completely normal.",
        "You mentioned feeling anxious in the mornings. Would you like me to guide you through a 2-minute breathing practice or help identify common morning stressors?",
        "Taking care of your mental health is just as important as physical health. Have you considered talking to a counselor or therapist? They can provide personalized strategies."
    ]
    
    // MARK: - Nutrition Responses
    static let nutritionResponses = [
        "Nutrition affects both physical and mental wellbeing. Try to include protein, healthy fats, and complex carbs in meals to keep blood sugar stable and mood balanced.",
        "Hydration is often overlooked but crucial. Aim for 8 glasses of water daily. Even mild dehydration can affect mood and energy levels.",
        "Eating mindfully can improve both digestion and satisfaction. Try eating one meal today without distractions - notice colors, textures, and flavors.",
        "Don't aim for perfection with nutrition. The 80/20 rule works well - make nutritious choices 80% of the time, and allow flexibility for the other 20%."
    ]
    
    // MARK: - Default Responses
    static let defaultResponses = [
        "That's an interesting point. How are you feeling about that situation right now?",
        "I hear you. It sounds like you're dealing with something important. Would you like to explore this further?",
        "Thank you for sharing that with me. What aspects of this feel most challenging for you?",
        "I appreciate you opening up about this. What kind of support would be most helpful right now?",
        "That makes sense. Sometimes talking through these things can provide clarity. What's your biggest concern about this?",
        "I understand. It's important to acknowledge what you're experiencing. What would feeling better look like for you?",
        "Thanks for trusting me with this. What do you think might be a good first step forward?",
        "I can see why that would be on your mind. Have you noticed any patterns or triggers related to this?"
    ]
    
    // MARK: - Response Selection Method
    static func getResponse(for message: String) -> String {
        let lowercaseMessage = message.lowercased()
        
        if lowercaseMessage.contains("stress") || lowercaseMessage.contains("anxious") || lowercaseMessage.contains("anxiety") {
            return stressResponses.randomElement() ?? defaultResponses.randomElement()!
        } else if lowercaseMessage.contains("sleep") || lowercaseMessage.contains("tired") || lowercaseMessage.contains("insomnia") {
            return sleepResponses.randomElement() ?? defaultResponses.randomElement()!
        } else if lowercaseMessage.contains("exercise") || lowercaseMessage.contains("workout") || lowercaseMessage.contains("fitness") {
            return exerciseResponses.randomElement() ?? defaultResponses.randomElement()!
        } else if lowercaseMessage.contains("mental health") || lowercaseMessage.contains("wellness") || lowercaseMessage.contains("mood") {
            return mentalHealthResponses.randomElement() ?? defaultResponses.randomElement()!
        } else if lowercaseMessage.contains("nutrition") || lowercaseMessage.contains("diet") || lowercaseMessage.contains("eating") {
            return nutritionResponses.randomElement() ?? defaultResponses.randomElement()!
        } else {
            return defaultResponses.randomElement()!
        }
    }
}

