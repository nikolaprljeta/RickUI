//
//  CharactersResponse.swift
//  RickAndMortyCharacters
//
//  Created by Nikola Prljeta on 14.11.22..
//

import Foundation

struct CharactersResponse: Codable {
    let info: Info
    let results: [Result]
}
