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
struct FAAAlerts: Codable{

    let generalDelays: GeneralDelays?
    
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
    
    case string(String)
    case double(Double)
    
    init(from decoder: Decoder) throws {
        if let double = try? decoder.singleValueContainer().decode(Double.self) {
            self = .double(double)
            return
        }
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
        throw Error.couldNotFindStringOrDouble
    }
    enum Error: Swift.Error {
        case couldNotFindStringOrDouble
    }
}
