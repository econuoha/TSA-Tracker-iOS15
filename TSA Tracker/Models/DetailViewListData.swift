//
//  DetailViewListData.swift
//  TSA Tracker
//
//  Created by Emmanuel Onouha on 6/27/22.
//

import Foundation

struct DetailViewListData: Codable, Identifiable{
    init() {
        self.code = ""
        self.name = ""
        self.rightnow_description = ""
        self.precheck = ""
        self.faa_alerts = FAAAlerts()
    }
    var id: String
    {
        return code
    }
    
    let code: String
    let name: String
    let rightnow_description: String
    var image: String{
        return precheck == "1" ? "tsapre" : "tsano"
    }
    let precheck: String
    let faa_alerts: FAAAlerts
}
struct FAAAlerts: Codable{
    init(){
        self.generalDelays = GeneralDelays()
    }
    let generalDelays: GeneralDelays?
}

struct GeneralDelays: Codable{
    init(){
        self.reason = ""
        self.trend = ""
    }
    let reason: String?
    let trend: String?
}
