//
//  AnimeFact.swift
//  AnimeFacts
//
//  Created by Suman Gurung on 21/06/2022.
//

import Foundation

struct AnimeFact: Codable {
    var success: Bool
    var img: String
    var totalFacts: Int
    var data: [AnimeFactData]
    
    enum CodingKeys: String, CodingKey {
        case success, img, data
        case totalFacts = "total_facts"
    }
}

struct AnimeFactData: Codable {
    var factId: Int
    var fact: String
    
    enum CodingKeys: String, CodingKey {
        case factId = "fact_id"
        case fact
    }
}
