import Foundation

enum FitnessGoal: String, CaseIterable {
    case gainMuscle = "Gain Muscle"
    case keepFit = "Keep Fit"
    case loseWeight = "Lose Weight"
}

enum FitnessLevel: String, CaseIterable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
}

class User: ObservableObject {
    @Published var name: String = ""
    @Published var age: Int = 0
    @Published var height: Double = 0.0  // in cm
    @Published var weight: Double = 0.0  // in kg
    @Published var fitnessLevel: FitnessLevel = .beginner
    @Published var fitnessGoal: FitnessGoal = .keepFit
    @Published var isOnboarded: Bool = false
    
    init() {}
} 