//
//  AnimeFactsService.swift
//  AnimeFacts
//
//  Created by Suman Gurung on 21/06/2022.
//

import Foundation
import Combine

protocol AnimeFactsServicing {
    func getAnimeFacts<F:Decodable>(urlString: String, type:F.Type) -> Future<F, NetworkError>
}

class AnimeFactsService: AnimeFactsServicing {
    func getAnimeFacts<F:Decodable>(urlString: String, type:F.Type) -> Future<F, NetworkError> {
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
                    let animeFacts = try jsonDecoder.decode(F.self, from: _data)
                    promise(.success(animeFacts))
                } catch {
                    promise(.failure(NetworkError.parsingError))
                }
            }
            dataTask.resume()
        }
    }
}
