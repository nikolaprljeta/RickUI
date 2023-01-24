//
//  Protocols.swift
//  RickAndMortyCharacters
//
//  Created by Nikola Prljeta on 22.11.22..
//

import Foundation
import Combine

protocol Fetchable {
    func fetchCharacters() -> AnyPublisher<CharactersResponse, Error>
}
