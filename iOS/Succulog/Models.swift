import Foundation

struct Succulent: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var date: Date = Date()
    var name: String
    var species: String
    var intervalDays: String
}
