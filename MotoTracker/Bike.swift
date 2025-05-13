import Foundation

struct Bike: Decodable {
    let name: String
    let imageNames: [String]
    let bikeDescription: String

    private enum CodingKeys: String, CodingKey {
        case name, imageNames, bikeDescription
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.imageNames = try container.decode([String].self, forKey: .imageNames)
        self.bikeDescription = try container.decode(String.self, forKey: .bikeDescription)
    }
}
