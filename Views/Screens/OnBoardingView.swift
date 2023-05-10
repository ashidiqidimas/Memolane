//
//  SwiftUIView.swift
//  
//
//  Created by Dimas on 18/04/23.
//

import SwiftUI

enum OnBoardingState: Int, CaseIterable {
    case backstory1 = 0
    case backstory2 = 1
    case problem = 2
    case hook = 3
    case solution = 4
    
    var body: String {
        switch self {
        case .backstory1:
            return "As a human, we all have our own beautiful memories"
        case .backstory2:
            return "As the time passed, sometimes we want to look back and\nre-experience those beautiful memories"
        case .problem:
            return "Unfortunately, to the irreversible nature of time, we can't really\nre-experience those memories"
        case .hook:
            return "But what if we can? and even walk through it?"
        case .solution:
            return "Introducing Memolane, a photo-oriented diary app that let you\nto literally walk through your memory lane using Augmented Reality"
        }
    }
}

struct OnBoardingView: View {
    
    @Binding var hasFinishedOnboarding: Bool
    
    @State var opacity = 1.0
    
    @State var state: OnBoardingState = OnBoardingState(rawValue: 0)!
    
    var body: some View {
        ZStack {
            Color.backgroundSecondary
                .ignoresSafeArea()
            
            VStack {
//                if state == .solution {
//                    Text("Introducing Memolane")
//                        .id(state.body)
//                        .transition(.springToTop)
//                        .font(.system(.title3, design: .rounded))
//                        .foregroundColor(.textSecondary)
//                }
                
                // Illustration animation
                ZStack {
                    GeometryReader { geo in
//                        Color.blue // TODO: change to image
                        
                        Image("onboarding-image-1")
                            .resizable()
                            .frame(
                                width: state.rawValue >= 3 ? 120 : 200,
                                height: state.rawValue >= 3 ? 90 : 150
                            )
                            .position(x: state.rawValue >= 3 ? 50 : 100, y: geo.size.height/2 - (state.rawValue >= 3 ? 40 : 0))
                            .rotation3DEffect(
                                .degrees(state.rawValue >= 3 ? 70 : 0), axis: (x: -0.1, y: 1, z: -0.1)
                            )
                        
//                        Color.green // TODO: change to image
                        Image("onboarding-image-2")
                            .resizable()
                            .frame(
                                width: state.rawValue >= 3 ? 120 : 200,
                                height: state.rawValue >= 3 ? 90 : 150
                            )
                            .position(x: geo.size.width - (state.rawValue >= 3 ? 50 : 100), y: geo.size.height/2 - (state.rawValue >= 3 ? 40 : 0))
                            .rotation3DEffect(
                                .degrees(state.rawValue >= 3 ? -70 : 0), axis: (x: 0.1, y: 1, z: -0.1)
                            )
                        
//                        RoundedRectangle(cornerSize: .init(width: 10, height: 10))
//                            .frame(width: geo.size.width, height: 10)
//                            .rotation3DEffect(
//                                .degrees(90), axis: (x: 0, y: 0, z: 1)
//                            )
//                            .rotation3DEffect(
//                                .degrees(80), axis: (x: 1, y: 0, z: 0)
//                            )
//                            .position(x: geo.size.width/2, y: geo.size.height - 96)
                        
                        
                        GeometryReader { inner in
                            RoundedRectangle(cornerSize: .init(width: 10, height: 8))
                                .frame(width: geo.size.width, height: 10)
                            
                            RoundedRectangle(cornerSize: .init(width: 10, height: 8))
                                .frame(width: 40, height: 12)
                                .rotationEffect(.degrees(40))
                                .position(x: geo.size.width - 15)
                                .offset(y: -5)
                            
                            RoundedRectangle(cornerSize: .init(width: 10, height: 8))
                                .frame(width: 40, height: 12)
                                .rotationEffect(.degrees(-40))
                                .position(x: geo.size.width - 15)
                                .offset(y: 15)
                        }
                        .foregroundColor(.primaryColor)
                        .frame(
                            width: state.rawValue >= 2 ? geo.size.width : 0,
                            height: state.rawValue >= 2 ? 12 : 10
                        )
                        .mask(
                                Rectangle()
                                    .frame(
                                        width: state.rawValue >= 2 ? geo.size.width : 0,
                                        height: 80
                                    )
                            )
                        .rotation3DEffect(
                            .degrees(state.rawValue >= 3 ? -90 : 0), axis: (x: 0, y: 0, z: 1)
                        )
                        .rotation3DEffect(
                            .degrees(state.rawValue >= 3 ? 82 : 0), axis: (x: 0.9, y: 0, z: 0)
                        )
                        .position(
                            x: state.rawValue >= 2 ? geo.size.width/2 : 0,
                            y: state.rawValue >= 3 ? geo.size.height - 96 : geo.size.height - 56
//                                y: geo.size.height - 96
                        )
                        
                        
//                        RoundedRectangle(cornerSize: .init(width: 10, height: 10))
//                            .frame(
//                                width: state.rawValue >= 2 ? geo.size.width : 0,
//                                height: state.rawValue >= 2 ? 12 : 10
//                            )
//                            .rotation3DEffect(
//                                .degrees(state.rawValue >= 4 ? 90 : 0), axis: (x: 0, y: 0, z: 1)
//                            )
//                            .rotation3DEffect(
//                                .degrees(state.rawValue >= 4 ? 82 : 0), axis: (x: 0.9, y: 0, z: 0)
//                            )
//                            .position(
//                                x: state.rawValue >= 2 ? geo.size.width/2 : 0,
//                                y: state.rawValue >= 4 ? geo.size.height - 96 : geo.size.height - 56
////                                y: geo.size.height - 96
//                            )
                    }
                    
                }
                .frame(width: 480, height: 360)
//                .background(.red)
                
                // ---
                
                Text(state.body)
                    .multilineTextAlignment(.center)
                    .id(state.body)
                    .transition(.springToTop)
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.textSecondary)
                    .frame(width: 600, height: 120)
            }
            
            VStack {
                Spacer()
                
                Text("Tap anywhere to continue")
                    .font(.system(.title2, design: .rounded))
                    .foregroundColor(.primaryColor)
                    .opacity(opacity)
                    .onAppear {
                        let baseAnimation = Animation.linear(duration: 0.6)
                        let repeated = baseAnimation.repeatForever()
                        
                        withAnimation(repeated) {
                            opacity = 0.5
                        }
                    }
                    .padding(.bottom, 40)
            }
        }
        .onTapGesture {
            if state.rawValue < OnBoardingState.allCases.count - 1 {
                withAnimation(Animation.easeOut(duration: 0.25)) {
                    state = OnBoardingState(rawValue: state.rawValue + 1)!
                }
            } else {
                hasFinishedOnboarding = true
            }
        }
        
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView(hasFinishedOnboarding: .constant(false))
    }
}
