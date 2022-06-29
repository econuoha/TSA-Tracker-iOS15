//
//  DetailView.swift
//  TSA Tracker
//
//  Created by Emmanuel Onouha on 6/27/22.
//

import SwiftUI

struct DetailView: View {
    //MARK: - Property
    @ObservedObject var detailViewListManager = DetailViewListManager()
    
    let airportCode: String?
    //MARK: - Body
    var body: some View {
        ZStack{
            Color(.white)
                .ignoresSafeArea()
            VStack{
                
                HStack {
                    Text(detailViewListManager.items.code)
                        .fontWeight(.bold)
                    Text(detailViewListManager.items.name)
                    Image(detailViewListManager.items.image)
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .center)
                }
                Spacer()
                HStack {
                    Image(systemName: "clock.badge.exclamationmark")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                    Spacer()
                    Text(detailViewListManager.items.rightnow_description)
                        .fontWeight(.bold)
                        
                }
                .padding(.horizontal)
                
                Spacer()
                
                if let anyDelays = detailViewListManager.items.faa_alerts?.generalDelays{
                    if let trend = anyDelays.trend{
                        Text(trend)
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    if let reason = anyDelays.reason{
                        Text(reason)
                    }
                }
                else
                {
                    
                    HStack {
                        Image(systemName: "airplane.departure").resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                        Spacer()
                        Text("No Current Delays")
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal)
                }
                Spacer()
                
                List(detailViewListManager.items.estimated_hourly_times!){ item in

                    HStack {
                        Text(item.timeslot)
                        Spacer()
                        Text(String(describing: item.waittime))
                    }
                    .padding(.horizontal)
                    
                    
                }
                
                
            }//: VStack
            
        }//: ZStack
        .preferredColorScheme(.light)
        .onAppear{
            if let safeCode = airportCode{
                detailViewListManager.fetchData(safeCode)
            }
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(airportCode: "DFW")
    }
}
