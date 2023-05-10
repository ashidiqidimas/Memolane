import SwiftUI

struct MemoryCard: View {
    var memoryItem: MemoryItem
    @Binding var selectedIndex: Int?
    @Binding var memoryItems: [MemoryItem]
    
    var isSelected: Bool {
        if let selectedIndex {
            return memoryItem == memoryItems[selectedIndex]
        } else {
            return false
        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Group {
                if let image = memoryItem.image {
                    Image(uiImage: image)
                        .resizable()
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 64, height: 64)
                        .background {
                            Rectangle()
                                .fill(Color.backgroundSecondary)
                                .frame(width: 64, height: 64)
                                .cornerRadius(16)
                        }
                }
            }
            .frame(width: 100, height: 100)
            .cornerRadius(16)
            
            VStack {
                Text(memoryItem.title.isEmpty ? "New Memory" : memoryItem.title)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.textPrimary)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer().frame(height: 8)
                
                Text(memoryItem.body)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.textTertiary)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding(.leading, 12)
        }
        .onTapGesture {
            if let index = memoryItems.firstIndex(where: { $0 == memoryItem }) {
                selectedIndex = index
            }
        }
        //        .padding(.vertical, 8)
        //        .frame(width: 375)
        .background(isSelected ? Color.backgroundPrimary : .clear)
        .cornerRadius(16)
    }
}
