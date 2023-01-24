//
//  APICaller.swift
//  RickAndMortyCharacters
//
//  Created by Nikola Prljeta on 14.11.22..
//

import Foundation
import Combine

final class APICaller: Fetchable {
    
    struct Constants {
        static let baseURL = "https://rickandmortyapi.com/api/"
        static let characters = "/character"
    }
    
    func fetchCharacters() -> AnyPublisher<CharactersResponse, Error> {
        
        let urlString = Constants.baseURL + Constants.characters
        let url = (URL(string: urlString))!
        let session = URLSession.shared
        
        return session.dataTaskPublisher(for: url)
            .compactMap({$0.data})
            .decode(type: CharactersResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
