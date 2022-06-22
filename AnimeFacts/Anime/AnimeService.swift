//
//  AnimeService.swift
//  AnimeFacts
//
//  Created by Suman Gurung on 21/06/2022.
//

import Foundation
import Combine

enum NetworkError: Error {
    case dataNotFound
    case parsingError
}

protocol AnimeServicing {
    func getAnime<A:Decodable>(urlString: String, type:A.Type) -> Future<A, NetworkError>
}

class AnimeService: AnimeServicing {
    func getAnime<A:Decodable>(urlString: String, type:A.Type) -> Future<A, NetworkError> {
        return Future { promise in
            let urlSession = URLSession.shared
            guard let url = URL(string: urlString) else {
                return
            }
            
            let dataTask = urlSession.dataTask(with: url) { data, urlResponse, error in
                guard let _data = data else {
                    promise(.failure(NetworkError.dataNotFound))
                    return
                }
                let jsonDecoder = JSONDecoder()
                
                do {
                    let animes = try jsonDecoder.decode(A.self, from: _data)
                    promise(.success(animes))
                } catch {
                    promise(.failure(NetworkError.parsingError))
                }
            }
            dataTask.resume()
        }
    }
}
