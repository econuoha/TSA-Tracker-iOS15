//
//  DetailViewListManager.swift
//  TSA Tracker
//
//  Created by Emmanuel Onouha on 6/27/22.
//

import Foundation

class DetailViewListManager: ObservableObject{
    
    //MARK: - Properties
    @Published var items = DetailViewListData()
    
    //MARK: - Main Function
    func fetchData(_ airportCode: String){
        if let url = URL(string: "https://www.tsawaittimes.com/api/airport/QiiJZRHzZwpzoAXgWdR6yrioJAIpqRyZ/\(airportCode)"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url)
                { data, response, error in
                if error == nil
                {
                    let decoder = JSONDecoder()
                    if let safeData = data
                    {
                        do
                        {
                            let results = try decoder.decode(DetailViewListData.self, from: safeData)
                            DispatchQueue.main.async {
                                self.items = results
                                print (self.items.estimated_hourly_times!)
                                
                            }
                        }
                        catch
                        {
                            print(error)
                        }
                    }
                    
                }
            }
                task.resume()
        }
    }
    
}
