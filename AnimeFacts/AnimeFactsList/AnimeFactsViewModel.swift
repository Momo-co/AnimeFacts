//
//  AnimeFactsViewModel.swift
//  AnimeFacts
//
//  Created by Suman Gurung on 21/06/2022.
//

import Foundation
import Combine

class AnimeFactsViewModel {
    @Published private(set) var animeFacts = AnimeFact(success: false, img: "", totalFacts: 0, data: [])
    var anyCancellable: AnyCancellable?
    
    private let animeFactsService: AnimeFactsServicing
    private let coordinator: AnimeFactsCoordinating
    var path: String
    
    init(
        animeFactsService: AnimeFactsServicing,
        coordinator: AnimeFactsCoordinating,
        path: String
    ) {
        self.animeFactsService = animeFactsService
        self.coordinator = coordinator
        self.path = path
    }
    
    func getAnimeFacts() {
        let url = "https://anime-facts-rest-api.herokuapp.com/api/v1/\(path)"
        
        let futurePublisher = animeFactsService.getAnimeFacts(urlString: url, type: AnimeFact.self)
        
        anyCancellable = futurePublisher.sink { completion in
            print(completion)
        } receiveValue: { animeFacts in
            self.animeFacts = animeFacts
        }
    }
    
    func getAnimeFact(index: Int) -> String {
        let animeFact = animeFacts.data[index].fact
        return animeFact
    }
    
    func getAnimeImageURLString() -> String {
        let animeImageURLString = animeFacts.img
        return animeImageURLString
    }
    
    func rewriteAnimeNameTitle() -> String {
        var animeNameTitle = path.replacingOccurrences(of: "_", with: " ").capitalized
        animeNameTitle += " Facts"
        return animeNameTitle
    }
    
    func openImageURL() {
        coordinator.open(imageURLString: getAnimeImageURLString())
    }
}
