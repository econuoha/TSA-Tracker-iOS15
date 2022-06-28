//
//  AirportListManager.swift
//  TSA Tracker
//
//  Created by Emmanuel Onouha on 6/27/22.
//

import Foundation

class AirportListManager: ObservableObject{
    
    //MARK: - Properties
    @Published var items = [ListItems]()
    
    //MARK: - Main Function
    func fetchData(){
        if let url = URL(string: "https://www.tsawaittimes.com/api/airports/QiiJZRHzZwpzoAXgWdR6yrioJAIpqRyZ"){
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
                            let results = try decoder.decode([ListItems].self, from: safeData)
                            DispatchQueue.main.async {
                                self.items = results
                                
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
