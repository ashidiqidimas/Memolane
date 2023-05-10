import SwiftUI

class HomeScreenViewModel: ObservableObject {
    @Published var memoryItems: [MemoryItem] = []
    
    @Published var selectedIndex: Int?
    
    // MARK: - Helpers
    
    init() {
        print("init home")
        memoryItems.append(contentsOf: HomeScreenViewModel.mockMemoryItems)
    }
    
    func memoryItem(for id: MemoryItem.ID) -> MemoryItem? {
        guard let memoryItem = memoryItems.first(where: { $0.id == id }) else {
            return nil
        }
        
        return memoryItem
    }
    
    func addMemoryItem() {
        let newMemoryItem = MemoryItem()
        withAnimation {
            memoryItems.append(newMemoryItem)
            selectedIndex = memoryItems.count - 1
        }
    }
    
}

// TODO: delete
extension HomeScreenViewModel {
    static let mockMemoryItems = [
        MemoryItem(
            image: UIImage(named: "concert"),
            title: "Our First Concert Together",
            body: """
            We went to Now Playing Fest in Bandung. It was really fun although it started badly due \
            to the weather. It was my first time going to a concert after the pandemic and at that \
            point I'm rarely listening to Indonesian songs, so I didn't know the lyrics for most of \
            the time. But Wisye sang along all the time and was really happy so I'm happy too!
            """
        ),
        MemoryItem(
            image: UIImage(named: "bromo"),
            title: "Bromo ⛰️",
            body: """
            Wisye visited me in Malang all the way down from Jakarta! Because it's not ordinary to \
            have someone who is willing to travel thousands kilometers, so I invite her to Bromo \
            mountain. it was fun although in the morning I just want to go home because it was so cold.
            """
        ),
    ]
}
