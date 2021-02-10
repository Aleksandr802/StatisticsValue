//
//  PostManager.swift
//  StatisticsValue
//
//  Created by Aleksandr Seminov on 10.02.2021.
//

import Foundation

struct  PostManager {
    let token  = "The accessToken you stored after authentication"

    func performRequest(with apiUrl: String, messageId: String, completionHandler: @escaping (PostModel) -> Void) {

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
    
    func parseJSON(statisticsData: Data) -> PostModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodetData = try decoder.decode(PostModel.self, from: statisticsData)
            print(decodetData.comments_count)
            
            return decodetData
        } catch {
            print(error)
            return nil
        }
    }
}
