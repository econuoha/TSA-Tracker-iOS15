//
//  OnboardingView.swift
//  TSA Tracker
//
//  Created by Emmanuel Onouha on 6/26/22.
//

import SwiftUI

struct OnboardingView: View {
    //MARK: - Property
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    @State private var isAnimating: Bool = false
    
    @State private var textTitle: String = "TSA Tracker"
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    
    @State private var imageOffset: CGSize = .zero
    
    @State private var indicatorOpacity: Double = 1.0
    
    @State private var buttonOffset: CGFloat = 0
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    //MARK: - Body
    var body: some View {
        
        ZStack {
            Color("AmericanLightBlue")
                .ignoresSafeArea()
            
            VStack(spacing: 20){
                //MARK: - Header
                    
                
                    Image("tsalogo")
                            .resizable()
                            .padding()
                            .scaledToFit()
                            .opacity(isAnimating ? 1 : 0)
                            .offset(y: isAnimating ? 0 : 40)
                            .animation(.easeInOut(duration: 1), value: isAnimating)
                    
                    
            
            
                //MARK: - Center
        
                VStack{
                    Image(systemName: "info.circle")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .frame(alignment: .topLeading)
                        .padding(.bottom)
                    Text("""
                         Green check mark indicates TSA precheck available.
                         Happy Tracking!
                         """)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    
                    Spacer()
                
                }//: Center
                
                Spacer()
                //MARK: - Footer
                Text("""
                     Data retrieved from tsawaittimes.com
                     """)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .font(.title3)
                .lineLimit(1)
                ZStack{
                    
                    //Parts of button
                    
                    //1. Background(static)
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    //2. Call-To-Action (static)
                    
                    Text("Start Tracking")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    //3. Capsule (dynamic width)
                    
                    HStack{
                        Capsule()
                            .fill(Color("AmericanDarkRed"))
                            .frame(width: buttonOffset + 80)
                        
                        Spacer()
                    }
                    
                    
                    //4. Circle (Draggable)
                    
                    HStack {
                        ZStack{
                            
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if gesture.translation.width > 0 && gesture.translation.width < buttonWidth - 80{
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded({ _ in
                                    
                                    withAnimation(Animation.easeOut(duration: 0.4)){
                                        if buttonOffset > buttonWidth / 2{
                                            hapticFeedback.notificationOccurred(.success)
                                            playSound(sound: "chimeup", type: "mp3")
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingViewActive = false
                                        } else {
                                            hapticFeedback.notificationOccurred(.warning)
                                            buttonOffset = 0
                                        }
                                    }
                                    
                                })
                        )//: Gesture
                        Spacer()
                    }
                    
                    
                }// : Footer
                .frame(width: buttonWidth, height: 80,
                       alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
            }//:Main VStack
        }//:Main ZStack
        .onAppear{
            isAnimating = true
            
        }
    }
}

//MARK: - Preview
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
