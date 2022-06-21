//
//  AnimeService.swift
//  AnimeFacts
//
//  Created by Suman Gurung on 21/06/2022.
//

import Foundation
import Combine

class AnimeService {
    func getAnime<A:Decodable>(urlString: String, type:A.Type) -> Future<A, Error> {
        return Future { promise in
            let urlSession = URLSession.shared
            guard let url = URL(string: urlString) else {
                return
            }
            
            let dataTask = urlSession.dataTask(with: url) { data, urlResponse, error in
                guard let _data = data else {
                    return
                }
                let jsonDecoder = JSONDecoder()
                
                do {
                    let animes = try jsonDecoder.decode(A.self, from: _data)
                    promise(.success(animes))
                } catch {
                    promise(.failure(error))
                }
            }
            dataTask.resume()
        }
    }
}
