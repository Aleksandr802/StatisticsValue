//
//  StatisticsManager.swift
//  StatisticsValue
//
//  Created by Aleksandr Seminov on 10.02.2021.
//

import Foundation

struct StatisticsManager {
     
    let token  = "ENTER-YOUR-TOKEN"

    func performRequest(with apiUrl: String, messageId: String, completionHandler: @escaping (StatModelResponse) -> Void) {

        let url = URL(string: (apiUrl + messageId))!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if error != nil || data == nil {
                print("Response Error")
            } else {
                do {
                    if let statisticsValue = parseJSON(statisticsData: data!){
                        completionHandler(statisticsValue)
                    }
                }
            }
        })
        task.resume()
    }
    
    func parseJSON(statisticsData: Data) -> StatModelResponse? {
        let decoder = JSONDecoder()
        
        do {
            let decodetData = try decoder.decode(StatModelResponse.self, from: statisticsData)
            
            return decodetData
        } catch {
            print(error)
            return nil
        }
    }
}
