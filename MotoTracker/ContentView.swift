//
//  ContentView.swift
//  MotoTracker
//
//  Created by William Gyrulf on 2025-05-13.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var bikeData: BikeDataManager
    
    var body: some View {
        NavigationView {
            List {
                ForEach($bikeData.bikes) { $bike in
                    BikeRow(bike: bike, isSeen: $bike.seen)
                        .environmentObject(bikeData)
                }
            }
            .navigationTitle("Bikes")
        }
    }
}

func loadBikeData() -> [Bike] {
    guard let url = Bundle.main.url(forResource: "bikes", withExtension: "json") else {
        print("❌ Could not find bikes.json")
        return []
    }

    do {
        let data = try Data(contentsOf: url)
        let bikes = try JSONDecoder().decode([Bike].self, from: data)
        return bikes
    } catch {
        print("❌ Failed to decode bikes.json: \(error)")
        return []
    }
}

class BikeDataManager: ObservableObject {
    @Published var bikes: [Bike] = []
    private let saveKey = "savedBikes"
    
    init() {
        load()
    }
    
    func load() {
        // First try loading user's saved data
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Bike].self, from: data) {
            bikes = decoded
            return
        }
        
        // Fallback to initial JSON if no saved data
        bikes = loadInitialBikeData()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(bikes) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    private func loadInitialBikeData() -> [Bike] {
        guard let url = Bundle.main.url(forResource: "bikes", withExtension: "json") else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Bike].self, from: data)
        } catch {
            return []
        }
    }
}

#Preview {
    ContentView()
}
