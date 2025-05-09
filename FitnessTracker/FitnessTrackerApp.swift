//
//  FitnessTrackerApp.swift
//  FitnessTracker
//
//  Created by Anthony on 5/9/25.
//

import SwiftUI

@main
struct FitnessTrackerApp: App {
    @StateObject private var user = User()
    
    var body: some Scene {
        WindowGroup {
            if user.isOnboarded {
                HomeView()
                    .environmentObject(user)
            } else {
                WelcomeView()
                    .environmentObject(user)
            }
        }
    }
}
