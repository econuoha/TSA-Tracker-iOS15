//
//  AirportListData.swift
//  TSA Tracker
//
//  Created by Emmanuel Onouha on 6/27/22.
//

import Foundation

struct ListItems: Codable, Identifiable{
    var id: String{
        return code
    }
    let code: String
    let name: String
    var image: String{
        return precheck == "1" ? "tsapre" : "tsano"
    }
    let precheck: String
    
}
