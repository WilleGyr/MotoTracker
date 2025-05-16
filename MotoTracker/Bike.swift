import Foundation

struct Bike: Codable, Identifiable {
    let id = UUID() // Add unique identifier
    let name: String
    let imageNames: [String]
    let bikeDescription: String
    var seen: Bool // New property
    
    private enum CodingKeys: String, CodingKey {
        case name, imageNames, bikeDescription, seen
    }
}
