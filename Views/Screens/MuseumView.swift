import SwiftUI
import RealityKit
import UIKit

struct MuseumView: View {
    @Environment(\.dismiss) var dismiss
    
    var memoryItems: [MemoryItem]
    @Binding var columnVisibility: NavigationSplitViewVisibility
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            MuseumControllerRepresentable(memories: memoryItems)
                .ignoresSafeArea()
                .toolbar(.hidden, for: .navigationBar)
            
            Button {
                columnVisibility = .doubleColumn
                print("dismiss tapped")
                dismiss()
            } label: {
                Text("Dismiss")
                    .padding(
                        EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20)
                    )
                    .background(.white)
                    .cornerRadius(100)
            }
            .padding(EdgeInsets(top: 16, leading: 24, bottom: 0, trailing: 0))
        }
        .preferredColorScheme(.light)
    }
}

struct MuseumControllerRepresentable: UIViewControllerRepresentable {
    var memories: [MemoryItem]
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = MuseumViewController()
        vc.memories = memories
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
