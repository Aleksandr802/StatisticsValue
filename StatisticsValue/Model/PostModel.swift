//
//  PostModel.swift
//  StatisticsValue
//
//  Created by Aleksandr Seminov on 10.02.2021.
//

import Foundation

struct PostModel: Decodable {
    
    let id: Int
    let slug : String
    let likes_count: Int
    let comments_count: Int
    let reposts_count: Int
    let bookmarks_count: Int
}
