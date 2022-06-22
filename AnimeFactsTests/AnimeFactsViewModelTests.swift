//
//  AnimeFactsViewModelTests.swift
//  AnimeFactsTests
//
//  Created by Suman Gurung on 22/06/2022.
//

import XCTest
@testable import AnimeFacts
import SafariServices

class AnimeFactsViewModelTests: XCTestCase {

    var animeFactsService: AnimeFactsServicing!
    var coordinator: AnimeFactsCoordinating!
    var navigationController: UINavigationController!
    var animeFactsViewModel: AnimeFactsViewModel!
    var path: String!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        animeFactsService = MockAnimeFactsService()
        navigationController = UINavigationController()
        coordinator = AnimeFactsCoordinator(navigationController: navigationController)
        path = "fma_brotherhood"
        animeFactsViewModel = AnimeFactsViewModel(
            animeFactsService: animeFactsService,
            coordinator: coordinator,
            path: path
        )
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        animeFactsService = nil
        coordinator = nil
        animeFactsViewModel = nil
        path = nil
    }

    func testGetAnimeFactsSucess() {
        XCTAssertEqual(animeFactsViewModel.animeFacts.success, false)
        animeFactsViewModel.getAnimeFacts(urlString: "Stub2")
        XCTAssertEqual(animeFactsViewModel.animeFacts.success, true)
    }

    func testGetAnimeFactsFailure() {
        XCTAssertEqual(animeFactsViewModel.animeFacts.success, false)
        animeFactsViewModel.getAnimeFacts(urlString: "Stub22")
        XCTAssertEqual(animeFactsViewModel.animeFacts.success, false)
    }
    
    func testGetAnimeFact() {
        animeFactsViewModel.getAnimeFacts(urlString: "Stub2")
        let expectedValue = "Law Of Equivalent Exchange Is Not Strictly Based On Eastern Or Western Alchemy"
        let actualValue = animeFactsViewModel.getAnimeFact(index: 3)
        XCTAssertEqual(expectedValue, actualValue)
    }
    
    func testGetAnimeImageURLString() {
        animeFactsViewModel.getAnimeFacts(urlString: "Stub2")
        let expectedValue = "https://m.media-amazon.com/images/M/MV5BZmEzN2YzOTItMDI5MS00MGU4LWI1NWQtOTg5ZThhNGQwYTEzXkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_.jpg"
        let actualValue = animeFactsViewModel.getAnimeImageURLString()
        XCTAssertEqual(expectedValue, actualValue)
    }
    
    func testRewriteAnimeNameTitle() {
        animeFactsViewModel.getAnimeFacts(urlString: "Stub2")
        let expectedValue = "Fma Brotherhood Facts"
        let actualValue = animeFactsViewModel.rewriteAnimeNameTitle()
        XCTAssertEqual(expectedValue, actualValue)
    }
}
