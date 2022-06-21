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
    
    private let animeService: AnimeService
    
    init(animeService: AnimeService) {
        self.animeService = animeService
    }
    
    func getAnimes() {
        let url = "https://anime-facts-rest-api.herokuapp.com/api/v1"
        
        let futurePublisher = animeService.getAnime(urlString: url, type: Anime.self)
        
        anyCancellable = futurePublisher.sink { completion in
            print(completion)
        } receiveValue: { anime in
            self.animes = anime
        }
    }
    
    func getAnimeList() -> [AnimeData] {
        let animeList = animes.data
        return animeList
    }
    func getAnimeImage(index: Int) -> String {
        let animeList = getAnimeList()
        return animeList[index].animeImg
    }
    
    func getAnimeName(index: Int) -> String {
        let animeList = getAnimeList()
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
