//
//  StatisticsModel.swift
//  StatisticsValue
//
//  Created by Aleksandr Seminov on 10.02.2021.
//

import Foundation

struct StatModelResponse: Codable {
    
    let data: [StatisticsModel]
}

struct StatisticsModel: Codable {
    
    let id: Int
    let nickname: String
    var avatar_image: AvatarImage
    
}

struct AvatarImage: Codable {
    let url: String
}
