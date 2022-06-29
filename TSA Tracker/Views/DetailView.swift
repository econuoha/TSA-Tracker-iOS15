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
            Color("ColorBlue")
                .ignoresSafeArea()
            VStack{
                List{
                    Section{
                        
                        HStack {
                            Spacer()
                            Text(detailViewListManager.items.code)
                                .fontWeight(.bold)
                            Text(detailViewListManager.items.name)
                                .font(.title3)
                            Image(detailViewListManager.items.image)
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                            Spacer()
                        }
                        
                    }//:Section
                    
                    Section{
                        HStack{
                            Image(systemName: "clock.badge.exclamationmark")
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .center)
                            Spacer()
                            Text(detailViewListManager.items.rightnow_description)
                                .fontWeight(.bold)
                        }
                        .padding(.horizontal)
                    }//:Section
                    header: {
                        Text("Current Wait Time")
                    }
                    
                    Section{
                        if let anyDelays = detailViewListManager.items.faa_alerts?.general_delays{
                            if let trend = anyDelays.trend, let reason = anyDelays.reason{
                                if trend == ""{
                                    HStack {
                                        Image(systemName: "airplane").resizable()
                                            .frame(width: 50, height: 50, alignment: .center)
                                        Spacer()
                                        Text("No General Delays")
                                            .fontWeight(.bold)
                                    }
                                    .padding(.horizontal)
                                }
                                else
                                {
                                    HStack{
                                        Text(trend)
                                            .font(.title3)
                                            .fontWeight(.bold)
                                        Spacer()
                                            Text(reason)
                                    }
                                }
                            }
                        }
                    }//:Section
                    header: {
                        Text("FAA General Delay Alerts")
                    }
                    Section{
                        if let anyDelays = detailViewListManager.items.faa_alerts?.ground_delays{
                            if let trend = anyDelays.reason, let reason = anyDelays.average{
                                if trend == ""{
                                    HStack {
                                        Image(systemName: "airplane.circle").resizable()
                                            .frame(width: 50, height: 50, alignment: .center)
                                        Spacer()
                                        Text("No Ground Delays")
                                            .fontWeight(.bold)
                                    }
                                    .padding(.horizontal)
                                }
                                else
                                {
                                    HStack{
                                        Text(trend)
                                            .font(.title3)
                                            .fontWeight(.bold)
                                        Spacer()
                                            Text(reason)
                                    }
                                }
                            }
                        }
                    }//:Section
                    header: {
                        Text("FAA Ground Delay Alerts")
                    }
                    
                    Section{
                        if let anyDelays = detailViewListManager.items.faa_alerts?.ground_stops{
                            if let trend = anyDelays.reason, let reason = anyDelays.end_time{
                                if trend == ""{
                                    HStack {
                                        Image(systemName: "airplane.circle.fill").resizable()
                                            .frame(width: 50, height: 50, alignment: .center)
                                        Spacer()
                                        Text("No Ground Stops")
                                            .fontWeight(.bold)
                                    }
                                    .padding(.horizontal)
                                }
                                else
                                {
                                    HStack{
                                        Text(trend)
                                            .font(.title3)
                                            .fontWeight(.bold)
                                        Spacer()
                                            Text(reason)
                                    }
                                }
                            }
                        }
                    }//:Section
                    header: {
                        Text("FAA General Stop Alerts")
                    }
                    
                    
                }//:List
                .moveDisabled(true)
                
                Section{
                    if let estWaitTime = detailViewListManager.items.estimated_hourly_times{
                        List{
                            Section{
                                ForEach(estWaitTime){ item in
                                    HStack {
                                        Text(item.timeslot)
                                        Spacer()
                                        if case let .mydouble(d) = item.waittime{
                                            Text(String(d) + " minutes")
                                        }
                                        if case let .mystring(d) = item.waittime{
                                            Text(String(d) + " minutes")
                                        }
                                    }//:Hstack
                                    .padding(.horizontal)
                                }//:ForEach
                            }//:Section
                        header:{
                            Text("Estimated Wait Time by Hour")
                                .frame(alignment: .center)
                        }
                            
                        }
                    }//:Section
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
