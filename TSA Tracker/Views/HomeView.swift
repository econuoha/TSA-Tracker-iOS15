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
    
    @ObservedObject var airportListManager = AirportListManager()
    
    @State private var searchText = ""
    
    var filteredMessages: [ListItems] {
        let forFilter = airportListManager.items
        
            if searchText.isEmpty {
                return forFilter
            } else {
                return forFilter.filter { $0.code.localizedCaseInsensitiveContains(searchText) }
            }
        }
    //MARK: - Body
    var body: some View {
        ZStack{
            Color("ColorRed")
                .ignoresSafeArea()
            VStack{
                //MARK: - Header
                NavigationView{
                    List(filteredMessages){item in
                        NavigationLink(destination: DetailView( airportCode: item.code)) {
                            HStack {
                                Text(item.code)
                                Text(item.name)
                                Spacer()
                                Image(item.image)
                                    .resizable()
                                    .frame(width: 20, height: 20, alignment: .trailing)
                            }
                            
                        }
                        .navigationTitle("Supported Airports")
                        .frame(alignment: .center)
                    }
                }
                
                .navigationBarHidden(false)
                .searchable(text: $searchText)
                .autocapitalization(.allCharacters)
                .disableAutocorrection(true)
                .frame(alignment: .center)
                .onAppear{
                    airportListManager.fetchData()
                    
                    
                }
                .onDisappear{
                    
                }
                
                
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
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
