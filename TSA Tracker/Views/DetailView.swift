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
            Color("ColorRed")
                .ignoresSafeArea()
            VStack{
                
                Text(detailViewListManager.items.code)
                Text(detailViewListManager.items.name)
                Image(detailViewListManager.items.image)
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
                Text(detailViewListManager.items.rightnow_description)
                if let anyDelays = detailViewListManager.items.faa_alerts.generalDelays{
                    if let trend = anyDelays.trend{
                        Text(trend)
                    }
                    if let reason = anyDelays.reason{
                        Text(reason)
                    }
                }
                
                
            }//: VStack
            
        }//: ZStack
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
