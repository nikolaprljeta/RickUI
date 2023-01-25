//
//  RickAndMortyCharactersTests.swift
//  RickAndMortyCharactersTests
//
//  Created by Nikola Prljeta on 14.11.22..
//

import XCTest
@testable import RickAndMortyCharacters

final class RickAndMortyCharactersTests: XCTestCase {
    
    var charactersViewModel: CharactersViewModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        charactersViewModel = CharactersViewModel()
        charactersViewModel?.showingFavs = Bool.random()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        charactersViewModel = nil
    }
    
    func test_CharacterViewModel_results_areEmpty() {
        //given
        
        //when
        guard let charactersViewModel = charactersViewModel else {
            XCTFail()
            return
        }
        
        //then
        XCTAssertTrue(charactersViewModel.results.isEmpty)
        XCTAssertEqual(charactersViewModel.results.count, 0)
    }
    
    func test_CharacterViewModel_results_areUpdated() {
        //given
        guard let charactersViewModel = charactersViewModel else {
            XCTFail()
            return
        }
        
        //when
        let loopCount: Int = Int.random(in: 1..<100)
        
        for _ in 0..<loopCount {
            let sampleRick = Result(id: 1,
                                    name: UUID().uuidString,
                                    status: UUID().uuidString,
                                    species: UUID().uuidString,
                                    type: UUID().uuidString,
                                    gender: UUID().uuidString,
                                    origin: sampleCrib,
                                    location: sampleCrib,
                                    image: UUID().uuidString,
                                    episode: [UUID().uuidString],
                                    url: UUID().uuidString,
                                    created: UUID().uuidString,
                                    isFaved: Bool.random())
            
            charactersViewModel.results.append(sampleRick)
        }
        
        //then
        XCTAssertTrue(!charactersViewModel.results.isEmpty)
        XCTAssertFalse(charactersViewModel.results.isEmpty)
        XCTAssertEqual(charactersViewModel.results.count, loopCount)
        XCTAssertNotEqual(charactersViewModel.results.count, 0)
        XCTAssertGreaterThan(charactersViewModel.results.count, 0)
    }
    
    func test_CharacterViewModel_favedCharacters_shouldExist() {
        //given
        let showingFavs: Bool = Bool.random()
        
        //when
        guard let charactersViewModel = charactersViewModel else {
            XCTFail()
            return
        }

        charactersViewModel.showingFavs = showingFavs
        
        //then
        XCTAssertEqual(charactersViewModel.showingFavs, showingFavs)
    }
    
    func test_CharacterViewModel_favedCharacters_shouldExist_stress() {
        for _ in 0..<100 {
            //given
            let showingFavs: Bool = Bool.random()
            
            //when
            guard let charactersViewModel = charactersViewModel else {
                XCTFail()
                return
            }

            charactersViewModel.showingFavs = showingFavs
            
            //then
            XCTAssertEqual(charactersViewModel.showingFavs, showingFavs)
        }
    }
    
    func test_CharacterViewModel_searchTerm_existsFalse() {
        //given
        let searchTerm = ""
        
        //when
        guard let charactersViewModel = charactersViewModel else {
            XCTFail()
            return
        }

        charactersViewModel.searchTerm = searchTerm
        
        //then
        XCTAssertEqual(charactersViewModel.searchTerm, searchTerm)
    }
    
    func test_CharacterViewModel_searchTerm_existsTrue() {
        //given
        let searchTerm = UUID().uuidString
        
        //when
        guard let charactersViewModel = charactersViewModel else {
            XCTFail()
            return
        }

        charactersViewModel.searchTerm = searchTerm
        
        //then
        XCTAssertEqual(charactersViewModel.searchTerm, searchTerm)
    }
    
    func test_CharacterViewModel_searchTerm_isFiltered() {
        //given
        guard let charactersViewModel = charactersViewModel else {
            XCTFail()
            return
        }
        
        //when
        let searchTerm = UUID().uuidString
        charactersViewModel.searchTerm = searchTerm
        
        //then
        XCTAssertTrue(!charactersViewModel.searchTerm.isEmpty)
        XCTAssertFalse(charactersViewModel.searchTerm.isEmpty)
        XCTAssertGreaterThan(charactersViewModel.searchTerm.count, 0)
        XCTAssertEqual(charactersViewModel.searchTerm, searchTerm)
    }
    
}
