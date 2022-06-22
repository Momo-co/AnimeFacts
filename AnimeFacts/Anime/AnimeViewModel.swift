//
//  AnimeViewModel.swift
//  AnimeFacts
//
//  Created by Suman Gurung on 21/06/2022.
//

import Foundation
import Combine

class AnimeViewModel {
    @Published private(set) var animes = Anime(success: false, data: [])
    var anyCancellable: AnyCancellable?
    
    private let animeService: AnimeServicing
    
    init(animeService: AnimeServicing) {
        self.animeService = animeService
    }
    
    func getAnimes(urlString: String) {
        
        let futurePublisher = animeService.getAnime(urlString: urlString, type: Anime.self)
        
        anyCancellable = futurePublisher.sink { completion in
            print(completion)
        } receiveValue: { anime in
            self.animes = anime
        }
    }
    
    func getAnimeImage(index: Int) -> String {
        let animeList = animes.data
        return animeList[index].animeImg
    }
    
    func getAnimeName(index: Int) -> String {
        let animeList = animes.data
        return animeList[index].animeName
    }
    
    func rewriteAnimeName(index: Int) -> String {
        let animeName = animes.data[index].animeName
        let newAnimeName = animeName.replacingOccurrences(of: "_", with: " ").capitalized
        return newAnimeName
    }
    
    deinit {
        anyCancellable?.cancel()
    }
}
