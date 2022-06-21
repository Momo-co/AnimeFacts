//
//  Anime.swift
//  AnimeFacts
//
//  Created by Suman Gurung on 21/06/2022.
//

import Foundation

struct Anime: Codable{
    var success: Bool
    var data: [Data]
    
    enum CodingKeys: CodingKey {
        case success, data
    }
}

struct Data: Codable {
    var animeId: Int
    var animeName: String
    var animeImg: String
    
    enum CodingKeys: String, CodingKey {
        case animeId = "anime_id"
        case animeName = "anime_name"
        case animeImg = "anime_img"
    }
}
