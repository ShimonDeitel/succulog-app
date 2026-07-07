import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    static let freeLimit = 8

    @Published var items: [Succulent] = []
    @Published var isPro: Bool = false

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("succulog_items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: Succulent) {
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: Succulent) {
        if let idx = items.firstIndex(where: { $0.id == item.id }) {
            items[idx] = item
            save()
        }
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: Succulent) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([Succulent].self, from: data) else {
            items = Store.seedData()
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    static func seedData() -> [Succulent] {
        [
        Succulent(date: Date().addingTimeInterval(-86400), name: "Echeveria Blue", species: "Echeveria", intervalDays: "21"),
        Succulent(date: Date().addingTimeInterval(-172800), name: "Barrel Cactus", species: "Ferocactus", intervalDays: "30"),
        Succulent(date: Date().addingTimeInterval(-259200), name: "Jade Plant", species: "Crassula", intervalDays: "18")
        ]
    }
}
