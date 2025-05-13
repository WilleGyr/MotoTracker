//
//  ContentView.swift
//  MotoTracker
//
//  Created by William Gyrulf on 2025-05-13.
//

import SwiftUI

struct ContentView: View {
    let bikes: [Bike] = loadBikeData()

    var body: some View {
        NavigationView {
            List(bikes, id: \.name) { bike in
                BikeRow(bike: bike)
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


#Preview {
    ContentView()
}
