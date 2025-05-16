//
//  MotoTrackerApp.swift
//  MotoTracker
//
//  Created by William Gyrulf on 2025-05-13.
//
import SwiftUI

@main
struct MotoTrackerApp: App {
    @StateObject private var bikeData = BikeDataManager()
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bikeData)
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .background {
                bikeData.save()
            }
        }
    }
}
