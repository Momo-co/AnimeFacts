//
//  MockAnimeFactsService.swift
//  AnimeFactsTests
//
//  Created by Suman Gurung on 22/06/2022.
//

import Foundation
import Combine
@testable import AnimeFacts

class MockAnimeFactsService: AnimeFactsServicing {
    
    func getAnimeFacts<F:Decodable>(urlString: String, type:F.Type) -> Future<F, NetworkError> {
        return Future { promise in
            if let url = Bundle(for: MockAnimeService.self).url(forResource: urlString, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(F.self, from: data)
                    promise(.success(jsonData))
                } catch {
                    print("error while decoding the JSON data")
                    promise(.failure(NetworkError.parsingError))
                }
            } else {
                promise(.failure(NetworkError.dataNotFound))
            }
        }
    }
}
