import SwiftUI

struct DescriptionContainerView: View {
    let title: String
    let description: String
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 80, weight: .semibold, design: .rounded))
                
                Spacer().frame(height: 48)
                
                Text(description)
                    .font(.system(size: 40, design: .rounded))
                
                Spacer()
            }
            .padding(.top, 240)
            .frame(width: 1280, alignment: .topLeading)
        }
        .ignoresSafeArea()
        .padding(128)
        .frame(width: 2048, height: 1536)
        .background(.white)
    }
}
