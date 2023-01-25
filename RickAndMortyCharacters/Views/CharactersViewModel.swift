//
//  CharactersViewModel.swift
//  RickAndMortyCharacters
//
//  Created by Nikola Prljeta on 14.11.22..
//

import SwiftUI
import Combine

final class CharactersViewModel: ObservableObject {
    @Published var results = [Result]()
    @Published var favedCharacter: Set<Int> = []
    @Published var showingFavs = false
    @Published var searchTerm = ""
    
    private var favs = FavoritesManager()
    private var cancellable = Set<AnyCancellable>()
    private let apiCaller = APICaller()
    internal var initialURL = APICaller.Constants.characters
    
    var searchResults: [Result] {
        if searchTerm.isEmpty {
            return results
        } else {
            return results.filter {$0.name.contains(searchTerm)}
        }
    }
    
    var filteredResults: [Result] {
        if showingFavs {
            return searchResults.filter({favedCharacter.contains($0.id)})
        } else {
            return searchResults
        }
    }
    
    init() {
        self.fetchCharacters()
        self.favedCharacter = favs.load()
    }
    
    func sortFavs() {
        withAnimation {
            showingFavs.toggle()
        }
    }
    
    func contains(_ item: Result) -> Bool {
        favedCharacter.contains(item.id)
    }
    
    func toggleFav(result: Result) {
        if contains(result) {
            favedCharacter.remove(result.id)
        } else {
            favedCharacter.insert(result.id)
        }
        favs.save(items: favedCharacter)
    }
    
    func fetchCharacters() {
        apiCaller.fetchCharacters()
            .sink(receiveCompletion: { completion in
                print("finished")
            }, receiveValue: { [weak self] container in
                self?.results.append(contentsOf: container.results.map({$0}))
            })
            .store(in: &cancellable)
    }
    
    func clearResponse() {
        results.removeAll()
    }
}
