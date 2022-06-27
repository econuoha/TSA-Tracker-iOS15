//
//  HomeView.swift
//  TSA Tracker
//
//  Created by Emmanuel Onouha on 6/26/22.
//

import SwiftUI

struct HomeView: View {
    //MARK: - Property
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    
    @State private var isAnimating: Bool = false

    //MARK: - Body
    var body: some View {
        ZStack{
            VStack{
                //MARK: - Header
                Spacer()
                //MARK: - Center
                
                //MARK: - Footer
                Button(action: {
                    withAnimation {
                        playSound(sound: "success", type: "m4a")
                        isOnboardingViewActive = true
                    }
                            
                }) {
                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                        .imageScale(.large)
                    Text("Home")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                }//: Button
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
            }// : VStack
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isAnimating = true
                }
            }
        }
    }
}

//MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
