//
//  AnimeViewModelTests.swift
//  AnimeFactsTests
//
//  Created by Suman Gurung on 22/06/2022.
//

import XCTest
@testable import AnimeFacts

class AnimeViewModelTests: XCTestCase {
    
    var animeService: AnimeServicing!
    var animeViewModel: AnimeViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        animeService = MockAnimeService()
        animeViewModel = AnimeViewModel(animeService: animeService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        animeService = nil
        animeViewModel = nil
    }
    
    func testGetAnimeSuccess() {
        XCTAssertEqual(animeViewModel.animes.success, false)
        animeViewModel.getAnimes(urlString: "Stub")
        XCTAssertEqual(animeViewModel.animes.success, true)
    }
    
    func testGetAnimeFailure() {
        XCTAssertEqual(animeViewModel.animes.success, false)
        animeViewModel.getAnimes(urlString: "stub9")
        XCTAssertEqual(animeViewModel.animes.success, false)
    }
    
    func testGetAnimeImage() {
        animeViewModel.getAnimes(urlString: "Stub")
        let expectedValue = "https://m.media-amazon.com/images/M/MV5BNTAzYTlkMWEtOTNjZC00ZDU0LWI5ODUtYTRmYzY0MTAzYWZlXkEyXkFqcGdeQXVyMzgxODM4NjM@._V1_FMjpg_UX1000_.jpg"
        let actualValue = animeViewModel.getAnimeImage(index: 1)
        XCTAssertEqual(expectedValue, actualValue)
    }
    
    func testGetAnimeName() {
        animeViewModel.getAnimes(urlString: "Stub")
        let expectedValue = "bleach"
        let actualValue = animeViewModel.getAnimeName(index: 0)
        XCTAssertEqual(expectedValue, actualValue)
    }
    
    func testRewriteAnimeName() {
        animeViewModel.getAnimes(urlString: "Stub")
        let expectedValue = "Black Clover"
        let actualValue = animeViewModel.rewriteAnimeName(index: 1)
        XCTAssertEqual(expectedValue, actualValue)
    }
    
}
