import SwiftUI

struct ImageContainerView: View {
    let uiImage: UIImage?
    
    var body: some View {
        ZStack {
            if let uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                //                    .aspectRatio(contentMode: .fit)
            } else {
                Text("No Image")
                    .font(.largeTitle)
            }
        }
        .ignoresSafeArea()
        //        .padding(128)
        .frame(width: 1536, height: 2048)
        .background(.white)
    }
}
