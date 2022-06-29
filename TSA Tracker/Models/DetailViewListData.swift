//
//  DetailViewListData.swift
//  TSA Tracker
//
//  Created by Emmanuel Onouha on 6/27/22.
//

import Foundation

let decoder = JSONDecoder()

struct DetailViewListData: Decodable, Identifiable{

    var id: String
    {
        return code
    }
    
    var code: String = ""
    var name: String = ""
    var rightnow_description: String = ""
    var image: String{
        return precheck == "1" ? "tsapre" : "tsano"
    }
    var precheck: String = ""
    var faa_alerts: FAAAlerts?
    var estimated_hourly_times: [EstimatedHourlyTimes]?
}
struct PreCheckCheckpoints: Codable{
    
}
struct Values: Codable{
    var terminalName: String
}
struct FAAAlerts: Codable{

    let general_delays: GeneralDelays
    let ground_stops:GroundStops
    let ground_delays: GroundDelays
}
struct GroundStops: Codable{

    let reason: String?
    let end_time: String?
}

struct GroundDelays: Codable{

    let reason: String?
    let average: String?
}

struct GeneralDelays: Codable{

    let reason: String?
    let trend: String?
}

struct EstimatedHourlyTimes: Decodable, Identifiable{

    var id: String{
        return timeslot
    }

    let timeslot: String
    let waittime: StringOrDouble
    
}

enum StringOrDouble: Decodable {
    
    case mystring(String)
    case mydouble(Double)
    
    init(from decoder: Decoder) throws {
        if let mydouble = try? decoder.singleValueContainer().decode(Double.self) {
            self = .mydouble(mydouble)
            return
        }
        if let mystring = try? decoder.singleValueContainer().decode(String.self) {
            self = .mystring(mystring)
            return
        }
        throw Error.couldNotFindStringOrDouble
    }
    enum Error: Swift.Error {
        case couldNotFindStringOrDouble
    }
}

