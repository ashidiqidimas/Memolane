import SwiftUI
import PhotosUI

struct MemoryView: View {
    @Binding var memoryItems: [MemoryItem]
    @Binding var selectedIndex: Int
    
    @State var selectedImage: PhotosPickerItem?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            TextField("Title", text: $memoryItems[selectedIndex].title, axis: .vertical)
                .foregroundColor(.textPrimary)
                .font(.system(.title, design: .rounded, weight: .medium))
            
            Spacer().frame(height: 16)
            
            TextField("Description", text: $memoryItems[selectedIndex].body, axis: .vertical)
                .foregroundColor(.textSecondary)
                .font(.system(.body, design: .rounded))
            
            Spacer().frame(height: 32)
            
            VStack {
                PhotosPicker(selection: $selectedImage, matching: .images) {
                    
                    if let image = memoryItems[selectedIndex].image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 400)
                            .background(Color.backgroundSecondary)
                            .cornerRadius(16)
                    } else {
                        HStack {
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 24, height: 24)
                            
                            Text("Tap to add image")
                                .font(.system(.title2, design: .rounded))
                        }
                        .frame(width: 300, height: 400)
                        .background(Color.backgroundSecondary)
                        .cornerRadius(16)
                        
                    }
                }
                .onChange(of: selectedImage) { _ in
                    Task {
                        if let data = try? await selectedImage?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                memoryItems[selectedIndex].image = uiImage
                                return
                            }
                        }
                        
                        print("Failed")
                    }
                }
                
                
            }
        }
        .frame(width: 520)
        
    }
}
