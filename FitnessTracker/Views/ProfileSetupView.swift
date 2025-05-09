import SwiftUI

struct ProfileSetupView: View {
    @EnvironmentObject var user: User
    @Environment(\.dismiss) var dismiss
    
    @State private var currentStep = 0
    @State private var ageString = ""
    @State private var heightString = ""
    @State private var weightString = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Progress indicator
                    ProgressView(value: Double(currentStep), total: 3)
                        .tint(.blue)
                        .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 30) {
                            // Step content
                            switch currentStep {
                            case 0:
                                basicInfoView
                            case 1:
                                fitnessLevelView
                            case 2:
                                goalSelectionView
                            default:
                                EmptyView()
                            }
                        }
                        .padding()
                    }
                    
                    // Navigation buttons
                    HStack(spacing: 20) {
                        if currentStep > 0 {
                            Button("Back") {
                                withAnimation {
                                    currentStep -= 1
                                }
                            }
                            .buttonStyle(.bordered)
                        }
                        
                        Button(currentStep == 2 ? "Finish" : "Next") {
                            if currentStep == 2 {
                                user.isOnboarded = true
                                dismiss()
                            } else {
                                withAnimation {
                                    currentStep += 1
                                }
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(currentStep == 0 && (ageString.isEmpty || heightString.isEmpty || weightString.isEmpty))
                    }
                    .padding(.bottom, 30)
                }
            }
            .navigationTitle("Profile Setup")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var basicInfoView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Basic Information")
                .font(.title2)
                .bold()
            
            VStack(spacing: 15) {
                TextField("Age", text: $ageString)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Height (cm)", text: $heightString)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Weight (kg)", text: $weightString)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
            }
            .onChange(of: ageString) { newValue in
                if let age = Int(newValue) {
                    user.age = age
                }
            }
            .onChange(of: heightString) { newValue in
                if let height = Double(newValue) {
                    user.height = height
                }
            }
            .onChange(of: weightString) { newValue in
                if let weight = Double(newValue) {
                    user.weight = weight
                }
            }
        }
    }
    
    private var fitnessLevelView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Your Fitness Level")
                .font(.title2)
                .bold()
            
            ForEach(FitnessLevel.allCases, id: \.self) { level in
                Button {
                    user.fitnessLevel = level
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(level.rawValue)
                                .font(.headline)
                            Text(fitnessLevelDescription(for: level))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        if user.fitnessLevel == level {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(user.fitnessLevel == level ? Color.blue : Color.gray.opacity(0.3))
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    private var goalSelectionView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Your Fitness Goal")
                .font(.title2)
                .bold()
            
            Picker("Select your goal", selection: $user.fitnessGoal) {
                ForEach(FitnessGoal.allCases, id: \.self) { goal in
                    Text(goal.rawValue).tag(goal)
                }
            }
            .pickerStyle(.segmented)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Goal Description")
                    .font(.headline)
                
                Text(goalDescription(for: user.fitnessGoal))
                    .foregroundColor(.secondary)
            }
            .padding(.top)
        }
    }
    
    private func fitnessLevelDescription(for level: FitnessLevel) -> String {
        switch level {
        case .beginner:
            return "New to fitness or returning after a long break"
        case .intermediate:
            return "Regular exercise with good form and consistency"
        case .advanced:
            return "Experienced with challenging workouts"
        }
    }
    
    private func goalDescription(for goal: FitnessGoal) -> String {
        switch goal {
        case .gainMuscle:
            return "Focus on strength training and progressive overload with proper nutrition to build muscle mass."
        case .keepFit:
            return "Maintain a balanced workout routine combining cardio and strength training for overall fitness."
        case .loseWeight:
            return "Combine cardio, strength training, and proper nutrition for healthy and sustainable weight loss."
        }
    }
}

#Preview {
    ProfileSetupView()
        .environmentObject(User())
} 