//
//  ContentView.swift
//  TSA Tracker
//
//  Created by Emmanuel Onouha on 6/26/22.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive:Bool = true
    
    var body: some View {
        
        ZStack{
            if isOnboardingViewActive{
                OnboardingView()
            }
            else
            {
                HomeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
