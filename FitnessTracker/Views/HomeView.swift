import SwiftUI

struct HomeView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "chart.bar.fill")
                }
            
            WorkoutView()
                .tabItem {
                    Label("Workout", systemImage: "figure.run")
                }
            
            ProgressTrackingView()
                .tabItem {
                    Label("Progress", systemImage: "chart.line.uptrend.xyaxis")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}

// Placeholder views that we'll implement next
struct DashboardView: View {
    var body: some View {
        NavigationView {
            Text("Dashboard Coming Soon")
                .navigationTitle("Dashboard")
        }
    }
}

struct WorkoutView: View {
    var body: some View {
        NavigationView {
            Text("Workout Details Coming Soon")
                .navigationTitle("Today's Workout")
        }
    }
}

struct ProgressTrackingView: View {
    var body: some View {
        NavigationView {
            Text("Progress Tracking Coming Soon")
                .navigationTitle("Progress")
        }
    }
}

struct ProfileView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        NavigationView {
            Form {
                Section("Personal Information") {
                    Text("Age: \(user.age)")
                    Text("Height: \(String(format: "%.1f", user.height)) cm")
                    Text("Weight: \(String(format: "%.1f", user.weight)) kg")
                }
                
                Section("Fitness") {
                    Text("Level: \(user.fitnessLevel.rawValue)")
                    Text("Goal: \(user.fitnessGoal.rawValue)")
                }
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(User())
} 