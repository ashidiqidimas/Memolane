//
//  SwiftUIView.swift
//  
//
//  Created by Dimas on 18/04/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var hasFinishedOnboarding = false
    
    var body: some View {
        if hasFinishedOnboarding {
            HomeScreenView()
        } else {
            OnBoardingView(hasFinishedOnboarding: $hasFinishedOnboarding)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
